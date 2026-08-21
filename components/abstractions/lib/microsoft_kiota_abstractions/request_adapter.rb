# frozen_string_literal: true

require_relative 'request_information'

module MicrosoftKiotaAbstractions
  module RequestAdapter
    def send_async(_request_info, _factory, _errors_mapping)
      raise NotImplementedError
    end

    # TODO: we're most likley missing something for enums and collections or at least at the implemenation level

    def get_serialization_writer_factory
      raise NotImplementedError
    end

    def set_base_url(_base_url)
      raise NotImplementedError
    end

    def get_base_url
      raise NotImplementedError
    end

    # Converts the given RequestInformation into a native HTTP request.
    def convert_to_native_request_async(_request_info)
      raise NotImplementedError
    end
  end
end
