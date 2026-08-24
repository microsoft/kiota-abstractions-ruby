# frozen_string_literal: true

module MicrosoftKiotaAbstractions
  module ParseNodeFactory
    def self.get_parse_node(_content_type, _content)
      raise NotImplementedError
    end
  end
end
