module MicrosoftKiotaAbstractions
  class AnonymousAuthenticationProvider
    include MicrosoftKiotaAbstractions::AuthenticationProvider
    def authenticate_request(request)
      # return an empty Fiber - all other authentication providers do the same, and the FaradayRequestAdapter requires it.
      Fiber.new do
      end
    end
  end
end