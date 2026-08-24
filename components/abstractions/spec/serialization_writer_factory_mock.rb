# frozen_string_literal: true

require 'microsoft_kiota_abstractions'
class SerializationWriterFactoryMock
  include MicrosoftKiotaAbstractions::SerializationWriterFactory

  def get_valid_content_type
    'application/json'
  end

  def get_serialization_writer(_clean_content)
    {}
  end
end
