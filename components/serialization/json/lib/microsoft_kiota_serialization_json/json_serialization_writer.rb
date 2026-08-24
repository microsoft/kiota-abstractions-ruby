# frozen_string_literal: true

require 'time'
require 'date'
require 'json'
require 'uuidtools'
require 'microsoft_kiota_abstractions'

module MicrosoftKiotaSerializationJson
  class JsonSerializationWriter
    include MicrosoftKiotaAbstractions::SerializationWriter

    def initialize
      @writer = {}
    end

    attr_reader :writer

    def write_string_value(key, value)
      raise StandardError, 'no key or value included in write_string_value(key, value)' if !key && !value
      return value.to_s unless key

      @writer[key] = (value || nil)
    end

    def write_boolean_value(key, value)
      raise StandardError, 'no key or value included in write_boolean_value(key, value)' if !key && !value
      return value unless key

      @writer[key] = value
    end

    def write_number_value(key, value)
      raise StandardError, 'no key or value included in write_number_value(key, value)' if !key && !value
      return value unless key

      @writer[key] = value
    end

    def write_float_value(key, value)
      raise StandardError, 'no key or value included in write_float_value(key, value)' if !key && !value
      return value unless key

      @writer[key] = value
    end

    def write_guid_value(key, value)
      raise StandardError, 'no key or value included in write_guid_value(key, value)' if !key && !value
      return value.to_s unless key

      @writer[key] = (value.to_s if value)
    end

    def write_date_value(key, value)
      raise StandardError, 'no key or value included in write_date_value(key, value)' if !key && !value
      return value.strftime('%Y-%m-%d') unless key

      @writer[key] = (value.strftime('%Y-%m-%d') if value)
    end

    def write_time_value(key, value)
      raise StandardError, 'no key or value included in write_time_value(key, value)' if !key && !value
      return value.strftime('%H:%M:%S%Z') unless key

      @writer[key] = (value.strftime('%H:%M:%S%Z') if value)
    end

    def write_date_time_value(key, value)
      raise StandardError, 'no key or value included in write_date_time_value(key, value)' if !key && !value
      return value.strftime('%Y-%m-%dT%H:%M:%S%Z') unless key

      @writer[key] = (value.strftime('%Y-%m-%dT%H:%M:%S%Z') if value)
    end

    def write_duration_value(key, value)
      raise StandardError, 'no key or value included in write_duration_value(key, value)' if !key && !value
      return value.string unless key

      @writer[key] = (value.string if value)
    end

    def write_collection_of_primitive_values(key, values)
      return unless values
      unless key
        return values.map do |v|
          write_any_value(nil, v)
        end
      end
      @writer[key] = values.map do |v|
        write_any_value(key, v)
      end
    end

    def write_collection_of_object_values(key, values)
      return unless values
      return values.map { |v| write_object_value(nil, v) } unless key

      @writer[key] = values.map { |v| object_value_hash(v) }
    end

    def write_object_value(key, value, *additional_values_to_merge)
      return unless value

      if key
        @writer[key] = object_value_hash(value, *additional_values_to_merge)
      else
        value.serialize(self)
        additional_values_to_merge.each { |v| v&.serialize(self) }
      end
    end

    def write_enum_value(key, values)
      write_string_value(key, values.to_s)
    end

    def get_serialized_content
      @writer.to_json # TODO: encode to byte array to stay content type agnostic
    end

    def write_additional_data(value)
      return unless value

      value.each do |x, y|
        write_any_value(x, y)
      end
    end

    private

    def object_value_hash(value, *additional_values_to_merge)
      temp = JsonSerializationWriter.new
      value.serialize(temp)
      additional_values_to_merge.each { |v| v&.serialize(temp) }
      temp.writer
    end

    public

    def write_any_value(key, value)
      if value
        if !value.nil? == value
          value
        elsif value.instance_of? String
          write_string_value(key, value)
        elsif value.instance_of? Integer
          write_number_value(key, value)
        elsif value.instance_of? Float
          write_float_value(key, value)
        elsif value.instance_of? DateTime
          write_date_time_value(key, value)
        elsif value.instance_of? Time
          write_time_value(key, value)
        elsif value.instance_of? Date
          write_date_value(key, value)
        elsif value.instance_of? MicrosoftKiotaAbstractions::ISODuration
          write_duration_value(key, value)
        elsif value.instance_of? Array
          write_collection_of_primitive_values(key, value)
        elsif value.is_a? Object
          value.to_s
        else
          raise StandardError, "encountered unknown value type during serialization #{value}"
        end
      else
        raise StandardError, 'no key included when writing json property' unless key

        @writer[key] = nil

      end
    end
  end
end
