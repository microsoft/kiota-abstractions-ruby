# frozen_string_literal: true

module MicrosoftKiotaAbstractions
  module Parsable
    def get_field_deserializers
      raise NotImplementedError
    end

    def serialize(_writer)
      raise NotImplementedError
    end
  end
end
