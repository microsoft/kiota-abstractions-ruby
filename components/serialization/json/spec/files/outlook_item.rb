# frozen_string_literal: true

require 'date'
require 'microsoft_kiota_abstractions'
require_relative 'entity'

module Files
  class OutlookItem < Files::Entity
    include MicrosoftKiotaAbstractions::Parsable

    ##
    # The categories associated with the item
    ##
    # Identifies the version of the item. Every time the item is changed, changeKey changes as well. This allows Exchange to apply changes to the correct version of the object. Read-only.
    ##
    # The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
    ##
    # The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
    ##
    ## Gets the categories property value. The categories associated with the item
    ## @return a string
    ##
    attr_accessor :categories

    ##
    ## Sets the categories property value. The categories associated with the item
    ## @param value Value to set for the categories property.
    ## @return a void
    ##

    ##
    ## Gets the changeKey property value. Identifies the version of the item. Every time the item is changed, changeKey changes as well. This allows Exchange to apply changes to the correct version of the object. Read-only.
    ## @return a string
    ##
    attr_accessor :change_key

    ##
    ## Sets the changeKey property value. Identifies the version of the item. Every time the item is changed, changeKey changes as well. This allows Exchange to apply changes to the correct version of the object. Read-only.
    ## @param value Value to set for the changeKey property.
    ## @return a void
    ##

    ##
    ## Instantiates a new outlookItem and sets the default values.
    ## @return a void
    ##

    ##
    ## Gets the createdDateTime property value. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
    ## @return a date_time
    ##
    attr_accessor :created_date_time

    ##
    ## Sets the createdDateTime property value. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
    ## @param value Value to set for the createdDateTime property.
    ## @return a void
    ##

    ##
    ## Creates a new instance of the appropriate class based on discriminator value
    ## @param parseNode The parse node to use to read the discriminator value and create the object
    ## @return a outlook_item
    ##
    def self.create_from_discriminator_value(parse_node)
      raise StandardError, 'parse_node cannot be null' if parse_node.nil?

      OutlookItem.new
    end

    ##
    ## The deserialization information for the current model
    ## @return a i_dictionary
    ##
    def get_field_deserializers
      super.merge({
                    'categories' => lambda { |n|
                      @categories = n.get_collection_of_primitive_values(String)
                    },
                    'changeKey' => ->(n) { @change_key = n.get_string_value },
                    'createdDateTime' => ->(n) { @created_date_time = n.get_date_time_value },
                    'lastModifiedDateTime' => ->(n) { @last_modified_date_time = n.get_date_time_value }
                  })
    end

    ##
    ## Gets the lastModifiedDateTime property value. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
    ## @return a date_time
    ##
    attr_accessor :last_modified_date_time

    ##
    ## Sets the lastModifiedDateTime property value. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
    ## @param value Value to set for the lastModifiedDateTime property.
    ## @return a void
    ##

    ##
    ## Serializes information the current object
    ## @param writer Serialization writer to use to serialize this model
    ## @return a void
    ##
    def serialize(writer)
      raise StandardError, 'writer cannot be null' if writer.nil?

      super
      writer.write_collection_of_primitive_values('categories', @categories)
      writer.write_string_value('changeKey', @change_key)
      writer.write_date_time_value('createdDateTime', @created_date_time)
      writer.write_date_time_value('lastModifiedDateTime', @last_modified_date_time)
    end
  end
end
