# frozen_string_literal: true

require_relative 'parse_node_factory'

module MicrosoftKiotaAbstractions
  class ParseNodeFactoryRegistry
    include ParseNodeFactory

    class << self
      attr_accessor :default_instance

      def default_instance = @default_instance ||= ParseNodeFactoryRegistry.new
    end

    def default_instance
      self.class.default_instance
    end

    def content_type_associated_factories
      @content_type_associated_factories ||= {}
    end

    def get_parse_node(content_type, content)
      raise StandardError, 'content type cannot be undefined or empty' unless content_type
      raise StandardError, 'content cannot be undefined or empty' unless content

      vendor_specific_content_type = content_type.split(';').first
      factory = @content_type_associated_factories[vendor_specific_content_type]
      return factory.get_parse_node(vendor_specific_content_type, content) if factory

      clean_content_type = vendor_specific_content_type.gsub(%r{[^/]+\+}i, '')
      factory = @content_type_associated_factories[clean_content_type]
      return factory.get_parse_node(clean_content_type, content) if factory

      raise StandardError, "Content type #{contentType} does not have a factory to be parsed"
    end
  end
end
