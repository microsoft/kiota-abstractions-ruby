# frozen_string_literal: true

require 'microsoft_kiota_abstractions'

module Files
  class ItemBody
    include MicrosoftKiotaAbstractions::Parsable
    include MicrosoftKiotaAbstractions::AdditionalDataHolder

    ##
    # Stores additional data not described in the OpenAPI description found when deserializing. Can be used for serialization as well.
    ##
    # The content of the item.
    ##
    # The contentType property
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
    ## Instantiates a new itemBody and sets the default values.
    ## @return a void
    ##
    def initialize
      @additional_data = {}
    end

    ##
    ## Gets the content property value. The content of the item.
    ## @return a string
    ##
    attr_accessor :content

    ##
    ## Sets the content property value. The content of the item.
    ## @param value Value to set for the content property.
    ## @return a void
    ##

    ##
    ## Gets the contentType property value. The contentType property
    ## @return a body_type
    ##
    attr_accessor :content_type

    ##
    ## Sets the contentType property value. The contentType property
    ## @param value Value to set for the contentType property.
    ## @return a void
    ##

    ##
    ## Creates a new instance of the appropriate class based on discriminator value
    ## @param parseNode The parse node to use to read the discriminator value and create the object
    ## @return a item_body
    ##
    def self.create_from_discriminator_value(parse_node)
      raise StandardError, 'parse_node cannot be null' if parse_node.nil?

      ItemBody.new
    end

    ##
    ## The deserialization information for the current model
    ## @return a i_dictionary
    ##
    def get_field_deserializers
      {
        'content' => ->(n) { @content = n.get_string_value },
        'contentType' => ->(n) { @content_type = n.get_enum_value(Files::BodyType) }
      }
    end

    ##
    ## Serializes information the current object
    ## @param writer Serialization writer to use to serialize this model
    ## @return a void
    ##
    def serialize(writer)
      raise StandardError, 'writer cannot be null' if writer.nil?

      writer.write_string_value('content', @content)
      writer.write_enum_value('contentType', @content_type)
      writer.write_additional_data(@additional_data)
    end
  end
end
