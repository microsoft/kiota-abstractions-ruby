# frozen_string_literal: true

module MicrosoftKiotaAbstractions
  module AdditionalDataHolder
    def additional_data
      @additional_data ||= {}
    end
  end
end
