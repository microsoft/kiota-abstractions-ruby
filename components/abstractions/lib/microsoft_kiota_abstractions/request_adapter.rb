require_relative 'request_information'

module MicrosoftKiotaAbstractions
  module RequestAdapter

    def send_async(request_info, factory, errors_mapping)
      raise NotImplementedError.new
    end

    # TODO we're most likley missing something for enums and collections or at least at the implemenation level

    def get_serialization_writer_factory()
      raise NotImplementedError.new
    end

    def set_base_url(base_url)
      raise NotImplementedError.new
    end

    def get_base_url()
      raise NotImplementedError.new
    end

    # Converts the given RequestInformation into a native HTTP request.
    def convert_to_native_request_async(request_info)
      raise NotImplementedError.new
    end

  end
end
