# frozen_string_literal: true

module MicrosoftKiotaAbstractions
  module SerializationWriterFactory
    def get_serialization_writer(_content_type)
      raise NotImplementedError
    end
  end
end
