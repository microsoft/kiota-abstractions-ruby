# frozen_string_literal: true

require_relative 'serialization_writer_factory'

module MicrosoftKiotaAbstractions
  class SerializationWriterFactoryRegistry
    include SerializationWriterFactory

    class << self
      attr_accessor :default_instance

      def default_instance = @default_instance ||= SerializationWriterFactoryRegistry.new
    end

    def default_instance
      self.class.default_instance
    end

    def content_type_associated_factories
      @content_type_associated_factories ||= {}
    end

    def get_serialization_writer(content_type)
      raise StandardError, 'content type cannot be undefined or empty' unless content_type

      vendor_specific_content_type = content_type.split(';').first
      factory = @content_type_associated_factories[vendor_specific_content_type]
      return factory.get_serialization_writer(vendor_specific_content_type) if factory

      clean_content_type = vendor_specific_content_type.gsub(%r{[^/]+\+}i, '')
      factory = @content_type_associated_factories[clean_content_type]
      return factory.get_serialization_writer(clean_content_type) if factory

      raise StandardError, "Content type #{contentType} does not have a factory to be serialized"
    end
  end
end
