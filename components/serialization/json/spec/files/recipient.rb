# frozen_string_literal: true

require 'microsoft_kiota_abstractions'

module Files
  class Recipient
    include MicrosoftKiotaAbstractions::Parsable
    include MicrosoftKiotaAbstractions::AdditionalDataHolder

    ##
    # Stores additional data not described in the OpenAPI description found when deserializing. Can be used for serialization as well.
    ##
    # The emailAddress property
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
    ## Instantiates a new recipient and sets the default values.
    ## @return a void
    ##
    def initialize
      @additional_data = {}
    end

    ##
    ## Creates a new instance of the appropriate class based on discriminator value
    ## @param parseNode The parse node to use to read the discriminator value and create the object
    ## @return a recipient
    ##
    def self.create_from_discriminator_value(parse_node)
      raise StandardError, 'parse_node cannot be null' if parse_node.nil?

      Recipient.new
    end

    ##
    ## Gets the emailAddress property value. The emailAddress property
    ## @return a email_address
    ##
    attr_accessor :email_address

    ##
    ## Sets the emailAddress property value. The emailAddress property
    ## @param value Value to set for the emailAddress property.
    ## @return a void
    ##

    ##
    ## The deserialization information for the current model
    ## @return a i_dictionary
    ##
    def get_field_deserializers
      {
        'emailAddress' => lambda { |n|
          @email_address = n.get_object_value(lambda { |pn|
            Files::EmailAddress.create_from_discriminator_value(pn)
          })
        }
      }
    end

    ##
    ## Serializes information the current object
    ## @param writer Serialization writer to use to serialize this model
    ## @return a void
    ##
    def serialize(writer)
      raise StandardError, 'writer cannot be null' if writer.nil?

      writer.write_object_value('emailAddress', @email_address)
      writer.write_additional_data(@additional_data)
    end
  end
end
