# frozen_string_literal: true

require 'microsoft_kiota_abstractions'
class RequestOptionMock
  include MicrosoftKiotaAbstractions::RequestOption

  attr_accessor :value

  def get_key
    'key'
  end
end
