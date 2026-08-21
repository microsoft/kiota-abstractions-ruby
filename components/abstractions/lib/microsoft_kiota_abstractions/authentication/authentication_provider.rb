# frozen_string_literal: true

module MicrosoftKiotaAbstractions
  module AuthenticationProvider
    def authenticate_request(_request, _additional_properties = {})
      raise NotImplementedError
    end
  end
end
