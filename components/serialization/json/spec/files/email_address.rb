# frozen_string_literal: true

require 'microsoft_kiota_abstractions'

module Files
  class EmailAddress
    include MicrosoftKiotaAbstractions::Parsable
    include MicrosoftKiotaAbstractions::AdditionalDataHolder

    ##
    # Stores additional data not described in the OpenAPI description found when deserializing. Can be used for serialization as well.
    ##
    # The email address of the person or entity.
    ##
    # The display name of the person or entity.
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
    ## Gets the address property value. The email address of the person or entity.
    ## @return a string
    ##
    attr_accessor :address

    ##
    ## Sets the address property value. The email address of the person or entity.
    ## @param value Value to set for the address property.
    ## @return a void
    ##

    ##
    ## Instantiates a new emailAddress and sets the default values.
    ## @return a void
    ##
    def initialize
      @additional_data = {}
    end

    ##
    ## Creates a new instance of the appropriate class based on discriminator value
    ## @param parseNode The parse node to use to read the discriminator value and create the object
    ## @return a email_address
    ##
    def self.create_from_discriminator_value(parse_node)
      raise StandardError, 'parse_node cannot be null' if parse_node.nil?

      EmailAddress.new
    end

    ##
    ## The deserialization information for the current model
    ## @return a i_dictionary
    ##
    def get_field_deserializers
      {
        'address' => ->(n) { @address = n.get_string_value },
        'name' => ->(n) { @name = n.get_string_value }
      }
    end

    ##
    ## Gets the name property value. The display name of the person or entity.
    ## @return a string
    ##
    attr_accessor :name

    ##
    ## Sets the name property value. The display name of the person or entity.
    ## @param value Value to set for the name property.
    ## @return a void
    ##

    ##
    ## Serializes information the current object
    ## @param writer Serialization writer to use to serialize this model
    ## @return a void
    ##
    def serialize(writer)
      raise StandardError, 'writer cannot be null' if writer.nil?

      writer.write_string_value('address', @address)
      writer.write_string_value('name', @name)
      writer.write_additional_data(@additional_data)
    end
  end
end
