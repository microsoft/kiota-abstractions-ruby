# frozen_string_literal: true

require 'microsoft_kiota_abstractions'
class ParseNodeFactoryMock
  include MicrosoftKiotaAbstractions::ParseNodeFactory

  def get_valid_content_type
    'application/json'
  end

  def get_parse_node(_clean_content_type, _content)
    {}
  end
end
