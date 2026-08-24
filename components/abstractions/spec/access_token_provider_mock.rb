# frozen_string_literal: true

require 'microsoft_kiota_abstractions'

class AccessTokenProviderMock
  extend MicrosoftKiotaAbstractions::AccessTokenProvider

  DUMMY_TOKEN = 'DummyToken'
  def get_authorization_token(_uri, _additional_properties = {})
    Fiber.new do
      DUMMY_TOKEN
    end
  end
end
