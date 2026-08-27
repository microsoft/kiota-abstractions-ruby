# frozen_string_literal: true

require 'time'
require 'date'
require 'json'
require 'uuidtools'
require 'microsoft_kiota_abstractions'

module MicrosoftKiotaSerializationJson
  class JsonParseNode
    include MicrosoftKiotaAbstractions::ParseNode

    def initialize(node)
      @current_node = node
    end

    # The scalar readers answer only for the type they are named after and return nil otherwise,
    # matching the dotnet and Python runtimes. Coercing instead would make every reader answer for
    # every payload, which leaves a composed type unable to tell which member it holds.
    def get_string_value
      @current_node.is_a?(String) ? @current_node : nil
    end

    def get_boolean_value
      [true, false].include?(@current_node) ? @current_node : nil
    end

    def get_number_value
      @current_node.is_a?(Integer) ? @current_node : nil
    end

    # Widened to Numeric because JSON writes a whole number without a fraction, so a float field can
    # legitimately arrive as an Integer.
    def get_float_value
      @current_node.is_a?(Numeric) ? @current_node.to_f : nil
    end

    def get_guid_value
      UUIDTools::UUID.parse(@current_node)
    end

    def get_date_value
      Date.parse(@current_node)
    end

    def get_time_value
      Time.parse(@current_node)
    end

    def get_date_time_value
      DateTime.parse(@current_node)
    end

    def get_duration_value
      MicrosoftKiotaAbstractions::ISODuration.new(@current_node)
    end

    # The generator passes the type as a class, except for booleans which it passes as a plain
    # string. A `case` cannot dispatch on that: `when String` asks whether the type is an instance
    # of String, and a class is an instance of Class, so every branch fell through to the string
    # reader. A hash keys on the class object itself.
    PRIMITIVE_READERS = {
      String => :get_string_value,
      Float => :get_float_value,
      Integer => :get_number_value,
      Date => :get_date_value,
      DateTime => :get_date_time_value,
      Time => :get_time_value,
      MicrosoftKiotaAbstractions::ISODuration => :get_duration_value,
      UUIDTools::UUID => :get_guid_value,
      'boolean' => :get_boolean_value,
      'Boolean' => :get_boolean_value
    }.freeze

    def get_collection_of_primitive_values(type)
      reader = PRIMITIVE_READERS[type]
      @current_node.map do |object|
        next if object.nil?
        # an untyped collection is generated as Object, which has no reader of its own; the parsed
        # JSON scalar is already the value, so it passes through rather than being stringified
        next object if reader.nil?

        JsonParseNode.new(object).public_send(reader)
      rescue StandardError => e
        raise e.class, "Failed to fetch #{type} type: #{e.message}"
      end
    end

    def get_collection_of_object_values(factory)
      raise StandardError, 'Factory cannot be null' if factory.nil?

      @current_node.map do |object|
        next if object.nil?

        current_parse_node = JsonParseNode.new(object)
        current_parse_node.get_object_value(factory)
      end
    end

    def get_object_value(factory)
      raise StandardError, 'Factory cannot be null' if factory.nil?

      item = factory.call(self)
      assign_field_values(item)
      item
    rescue StandardError => e
      raise e.class, 'Error during deserialization'
    end

    def assign_field_values(item)
      fields = item.get_field_deserializers
      @current_node.each do |k, v|
        next if v.nil?

        deserializer = fields[k]
        if deserializer
          deserializer.call(JsonParseNode.new(v))
        elsif item.additional_data
          item.additional_data[k] = v
        else
          item.additional_data = Hash.new({ k => v })
        end
      end
    end

    def get_enum_values(_type)
      raw_values = get_string_value
      return [] if raw_values.nil?

      raw_values.split(',').map(&:strip)
    end

    def get_enum_value(type)
      items = get_enum_values(type).map(&:to_sym)
      items[0] if items.length.positive?
    end

    def get_child_node(name)
      raise StandardError, 'Name cannot be null' if name.nil? || name.empty?

      raw_value = @current_node[name]
      JsonParseNode.new(raw_value) if raw_value
    end
  end
end
