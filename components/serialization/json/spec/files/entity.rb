# frozen_string_literal: true

require 'microsoft_kiota_abstractions'

module Files
  class Entity
    include MicrosoftKiotaAbstractions::Parsable
    include MicrosoftKiotaAbstractions::AdditionalDataHolder

    ##
    # Stores additional data not described in the OpenAPI description found when deserializing. Can be used for serialization as well.
    ##
    # The unique idenfier for an entity. Read-only.
    ##
    ## Gets the additionalData property value. Stores additional data not described in the OpenAPI description found when deserializing. Can be used for serialization as well.
    ## @return a i_dictionary
    ##
    attr_accessor :additional_data

    ##
    ## Sets the additionalData property value. Stores additional data not described in the OpenAPI description found when deserializing. Can be used for serialization as well.
    ## @param value Value to set for the AdditionalData property.
    ## @return a void
    ##

    ##
    ## Instantiates a new entity and sets the default values.
    ## @return a void
    ##
    def initialize
      @additional_data = {}
    end

    ##
    ## Creates a new instance of the appropriate class based on discriminator value
    ## @param parseNode The parse node to use to read the discriminator value and create the object
    ## @return a entity
    ##
    def self.create_from_discriminator_value(parse_node)
      raise StandardError, 'parse_node cannot be null' if parse_node.nil?

      Entity.new
    end

    ##
    ## The deserialization information for the current model
    ## @return a i_dictionary
    ##
    def get_field_deserializers
      {
        'id' => ->(n) { @id = n.get_string_value }
      }
    end

    ##
    ## Gets the id property value. The unique idenfier for an entity. Read-only.
    ## @return a string
    ##
    attr_accessor :id

    ##
    ## Sets the id property value. The unique idenfier for an entity. Read-only.
    ## @param value Value to set for the id property.
    ## @return a void
    ##

    ##
    ## Serializes information the current object
    ## @param writer Serialization writer to use to serialize this model
    ## @return a void
    ##
    def serialize(writer)
      raise StandardError, 'writer cannot be null' if writer.nil?

      writer.write_string_value('id', @id)
      writer.write_additional_data(@additional_data)
    end
  end
end
