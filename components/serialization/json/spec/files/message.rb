# frozen_string_literal: true

require 'date'
require 'microsoft_kiota_abstractions'
require_relative 'outlook_item'

module Files
  class Message < Files::OutlookItem
    include MicrosoftKiotaAbstractions::Parsable

    attr_accessor :guid_id

    ##
    # The fileAttachment and itemAttachment attachments for the message.
    ##
    # The Bcc: recipients for the message.
    ##
    # The body property
    ##
    # The first 255 characters of the message body. It is in text format.
    ##
    # The Cc: recipients for the message.
    ##
    # The ID of the conversation the email belongs to.
    ##
    # Indicates the position of the message within the conversation.
    ##
    # The collection of open extensions defined for the message. Nullable.
    ##
    # The flag property
    ##
    # The from property
    ##
    # Indicates whether the message has attachments. This property doesn't include inline attachments, so if a message contains only inline attachments, this property is false. To verify the existence of inline attachments, parse the body property to look for a src attribute, such as <IMG src='cid:image001.jpg@01D26CD8.6C05F070'>.
    ##
    # The importance property
    ##
    # The inferenceClassification property
    ##
    # The internetMessageHeaders property
    ##
    # The internetMessageId property
    ##
    # The isDeliveryReceiptRequested property
    ##
    # The isDraft property
    ##
    # The isRead property
    ##
    # The isReadReceiptRequested property
    ##
    # The collection of multi-value extended properties defined for the message. Nullable.
    ##
    # The parentFolderId property
    ##
    # The receivedDateTime property
    ##
    # The replyTo property
    ##
    # The sender property
    ##
    # The sentDateTime property
    ##
    # The collection of single-value extended properties defined for the message. Nullable.
    ##
    # The subject property
    ##
    # The toRecipients property
    ##
    # The uniqueBody property
    ##
    # The webLink property
    ##
    ## Gets the attachments property value. The fileAttachment and itemAttachment attachments for the message.
    ## @return a attachment
    ##
    attr_accessor :attachments

    ##
    ## Sets the attachments property value. The fileAttachment and itemAttachment attachments for the message.
    ## @param value Value to set for the attachments property.
    ## @return a void
    ##

    ##
    ## Gets the bccRecipients property value. The Bcc: recipients for the message.
    ## @return a recipient
    ##
    attr_accessor :bcc_recipients

    ##
    ## Sets the bccRecipients property value. The Bcc: recipients for the message.
    ## @param value Value to set for the bccRecipients property.
    ## @return a void
    ##

    ##
    ## Gets the body property value. The body property
    ## @return a item_body
    ##
    attr_accessor :body

    ##
    ## Sets the body property value. The body property
    ## @param value Value to set for the body property.
    ## @return a void
    ##

    ##
    ## Gets the bodyPreview property value. The first 255 characters of the message body. It is in text format.
    ## @return a string
    ##
    attr_accessor :body_preview

    ##
    ## Sets the bodyPreview property value. The first 255 characters of the message body. It is in text format.
    ## @param value Value to set for the bodyPreview property.
    ## @return a void
    ##

    ##
    ## Gets the ccRecipients property value. The Cc: recipients for the message.
    ## @return a recipient
    ##
    attr_accessor :cc_recipients

    ##
    ## Sets the ccRecipients property value. The Cc: recipients for the message.
    ## @param value Value to set for the ccRecipients property.
    ## @return a void
    ##

    ##
    ## Instantiates a new message and sets the default values.
    ## @return a void
    ##

    ##
    ## Gets the conversationId property value. The ID of the conversation the email belongs to.
    ## @return a string
    ##
    attr_accessor :conversation_id

    ##
    ## Sets the conversationId property value. The ID of the conversation the email belongs to.
    ## @param value Value to set for the conversationId property.
    ## @return a void
    ##

    ##
    ## Gets the conversationIndex property value. Indicates the position of the message within the conversation.
    ## @return a binary
    ##
    attr_accessor :conversation_index

    ##
    ## Sets the conversationIndex property value. Indicates the position of the message within the conversation.
    ## @param value Value to set for the conversationIndex property.
    ## @return a void
    ##

    ##
    ## Creates a new instance of the appropriate class based on discriminator value
    ## @param parseNode The parse node to use to read the discriminator value and create the object
    ## @return a message
    ##
    def self.create_from_discriminator_value(parse_node)
      raise StandardError, 'parse_node cannot be null' if parse_node.nil?

      Message.new
    end

    ##
    ## Gets the extensions property value. The collection of open extensions defined for the message. Nullable.
    ## @return a extension
    ##
    attr_accessor :extensions

    ##
    ## Sets the extensions property value. The collection of open extensions defined for the message. Nullable.
    ## @param value Value to set for the extensions property.
    ## @return a void
    ##

    ##
    ## Gets the flag property value. The flag property
    ## @return a followup_flag
    ##
    attr_accessor :flag

    ##
    ## Sets the flag property value. The flag property
    ## @param value Value to set for the flag property.
    ## @return a void
    ##

    ##
    ## Gets the from property value. The from property
    ## @return a recipient
    ##
    attr_accessor :from

    ##
    ## Sets the from property value. The from property
    ## @param value Value to set for the from property.
    ## @return a void
    ##

    ##
    ## The deserialization information for the current model
    ## @return a i_dictionary
    ##
    def get_field_deserializers
      super.merge({
                    'guidId' => ->(n) { @guid_id = n.get_guid_value },
                    'bccRecipients' => lambda { |n|
                      @bcc_recipients = n.get_collection_of_object_values(lambda { |pn|
                        Files::Recipient.create_from_discriminator_value(pn)
                      })
                    },
                    'body' => lambda { |n|
                      @body = n.get_object_value(lambda { |pn|
                        Files::ItemBody.create_from_discriminator_value(pn)
                      })
                    },
                    'bodyPreview' => ->(n) { @body_preview = n.get_string_value },
                    'ccRecipients' => lambda { |n|
                      @cc_recipients = n.get_collection_of_object_values(lambda { |pn|
                        Files::Recipient.create_from_discriminator_value(pn)
                      })
                    },
                    'conversationId' => ->(n) { @conversation_id = n.get_string_value },
                    'conversationIndex' => ->(n) { @conversation_index = n.get_string_value },
                    'from' => lambda { |n|
                      @from = n.get_object_value(lambda { |pn|
                        Files::Recipient.create_from_discriminator_value(pn)
                      })
                    },
                    'hasAttachments' => ->(n) { @has_attachments = n.get_boolean_value },
                    'internetMessageId' => ->(n) { @internet_message_id = n.get_string_value },
                    'isDeliveryReceiptRequested' => lambda { |n|
                      @is_delivery_receipt_requested = n.get_boolean_value
                    },
                    'isDraft' => ->(n) { @is_draft = n.get_boolean_value },
                    'isRead' => ->(n) { @is_read = n.get_boolean_value },
                    'isReadReceiptRequested' => lambda { |n|
                      @is_read_receipt_requested = n.get_boolean_value
                    },
                    'parentFolderId' => ->(n) { @parent_folder_id = n.get_string_value },
                    'receivedDateTime' => ->(n) { @received_date_time = n.get_date_time_value },
                    'replyTo' => lambda { |n|
                      @reply_to = n.get_collection_of_object_values(lambda { |pn|
                        Files::Recipient.create_from_discriminator_value(pn)
                      })
                    },
                    'sender' => lambda { |n|
                      @sender = n.get_object_value(lambda { |pn|
                        Files::Recipient.create_from_discriminator_value(pn)
                      })
                    },
                    'sentDateTime' => ->(n) { @sent_date_time = n.get_date_time_value },
                    'subject' => ->(n) { @subject = n.get_string_value },
                    'toRecipients' => lambda { |n|
                      @to_recipients = n.get_collection_of_object_values(lambda { |pn|
                        Files::Recipient.create_from_discriminator_value(pn)
                      })
                    },
                    'uniqueBody' => lambda { |n|
                      @unique_body = n.get_object_value(lambda { |pn|
                        Files::ItemBody.create_from_discriminator_value(pn)
                      })
                    },
                    'webLink' => ->(n) { @web_link = n.get_string_value }
                  })
    end

    ##
    ## Gets the hasAttachments property value. Indicates whether the message has attachments. This property doesn't include inline attachments, so if a message contains only inline attachments, this property is false. To verify the existence of inline attachments, parse the body property to look for a src attribute, such as <IMG src='cid:image001.jpg@01D26CD8.6C05F070'>.
    ## @return a boolean
    ##
    attr_accessor :has_attachments

    ##
    ## Sets the hasAttachments property value. Indicates whether the message has attachments. This property doesn't include inline attachments, so if a message contains only inline attachments, this property is false. To verify the existence of inline attachments, parse the body property to look for a src attribute, such as <IMG src='cid:image001.jpg@01D26CD8.6C05F070'>.
    ## @param value Value to set for the hasAttachments property.
    ## @return a void
    ##

    ##
    ## Gets the importance property value. The importance property
    ## @return a importance
    ##
    attr_accessor :importance

    ##
    ## Sets the importance property value. The importance property
    ## @param value Value to set for the importance property.
    ## @return a void
    ##

    ##
    ## Gets the inferenceClassification property value. The inferenceClassification property
    ## @return a inference_classification_type
    ##
    attr_accessor :inference_classification

    ##
    ## Sets the inferenceClassification property value. The inferenceClassification property
    ## @param value Value to set for the inferenceClassification property.
    ## @return a void
    ##

    ##
    ## Gets the internetMessageHeaders property value. The internetMessageHeaders property
    ## @return a internet_message_header
    ##
    attr_accessor :internet_message_headers

    ##
    ## Sets the internetMessageHeaders property value. The internetMessageHeaders property
    ## @param value Value to set for the internetMessageHeaders property.
    ## @return a void
    ##

    ##
    ## Gets the internetMessageId property value. The internetMessageId property
    ## @return a string
    ##
    attr_accessor :internet_message_id

    ##
    ## Sets the internetMessageId property value. The internetMessageId property
    ## @param value Value to set for the internetMessageId property.
    ## @return a void
    ##

    ##
    ## Gets the isDeliveryReceiptRequested property value. The isDeliveryReceiptRequested property
    ## @return a boolean
    ##
    attr_accessor :is_delivery_receipt_requested

    ##
    ## Sets the isDeliveryReceiptRequested property value. The isDeliveryReceiptRequested property
    ## @param value Value to set for the isDeliveryReceiptRequested property.
    ## @return a void
    ##

    ##
    ## Gets the isDraft property value. The isDraft property
    ## @return a boolean
    ##
    attr_accessor :is_draft

    ##
    ## Sets the isDraft property value. The isDraft property
    ## @param value Value to set for the isDraft property.
    ## @return a void
    ##

    ##
    ## Gets the isRead property value. The isRead property
    ## @return a boolean
    ##
    attr_accessor :is_read

    ##
    ## Sets the isRead property value. The isRead property
    ## @param value Value to set for the isRead property.
    ## @return a void
    ##

    ##
    ## Gets the isReadReceiptRequested property value. The isReadReceiptRequested property
    ## @return a boolean
    ##
    attr_accessor :is_read_receipt_requested

    ##
    ## Sets the isReadReceiptRequested property value. The isReadReceiptRequested property
    ## @param value Value to set for the isReadReceiptRequested property.
    ## @return a void
    ##

    ##
    ## Gets the multiValueExtendedProperties property value. The collection of multi-value extended properties defined for the message. Nullable.
    ## @return a multi_value_legacy_extended_property
    ##
    attr_accessor :multi_value_extended_properties

    ##
    ## Sets the multiValueExtendedProperties property value. The collection of multi-value extended properties defined for the message. Nullable.
    ## @param value Value to set for the multiValueExtendedProperties property.
    ## @return a void
    ##

    ##
    ## Gets the parentFolderId property value. The parentFolderId property
    ## @return a string
    ##
    attr_accessor :parent_folder_id

    ##
    ## Sets the parentFolderId property value. The parentFolderId property
    ## @param value Value to set for the parentFolderId property.
    ## @return a void
    ##

    ##
    ## Gets the receivedDateTime property value. The receivedDateTime property
    ## @return a date_time
    ##
    attr_accessor :received_date_time

    ##
    ## Sets the receivedDateTime property value. The receivedDateTime property
    ## @param value Value to set for the receivedDateTime property.
    ## @return a void
    ##

    ##
    ## Gets the replyTo property value. The replyTo property
    ## @return a recipient
    ##
    attr_accessor :reply_to

    ##
    ## Sets the replyTo property value. The replyTo property
    ## @param value Value to set for the replyTo property.
    ## @return a void
    ##

    ##
    ## Gets the sender property value. The sender property
    ## @return a recipient
    ##
    attr_accessor :sender

    ##
    ## Sets the sender property value. The sender property
    ## @param value Value to set for the sender property.
    ## @return a void
    ##

    ##
    ## Gets the sentDateTime property value. The sentDateTime property
    ## @return a date_time
    ##
    attr_accessor :sent_date_time

    ##
    ## Sets the sentDateTime property value. The sentDateTime property
    ## @param value Value to set for the sentDateTime property.
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
      writer.write_guid_value('guidId', @guid_id)
      writer.write_collection_of_object_values('attachments', @attachments)
      writer.write_collection_of_object_values('bccRecipients', @bcc_recipients)
      writer.write_object_value('body', @body)
      writer.write_string_value('bodyPreview', @body_preview)
      writer.write_collection_of_object_values('ccRecipients', @cc_recipients)
      writer.write_string_value('conversationId', @conversation_id)
      # writer.write_object_value("conversationIndex", @conversation_index) byte array is not supported yet
      writer.write_collection_of_object_values('extensions', @extensions)
      writer.write_object_value('flag', @flag)
      writer.write_object_value('from', @from)
      writer.write_boolean_value('hasAttachments', @has_attachments)
      writer.write_enum_value('importance', @importance)
      writer.write_enum_value('inferenceClassification', @inference_classification)
      writer.write_collection_of_object_values('internetMessageHeaders', @internet_message_headers)
      writer.write_string_value('internetMessageId', @internet_message_id)
      writer.write_boolean_value('isDeliveryReceiptRequested', @is_delivery_receipt_requested)
      writer.write_boolean_value('isDraft', @is_draft)
      writer.write_boolean_value('isRead', @is_read)
      writer.write_boolean_value('isReadReceiptRequested', @is_read_receipt_requested)
      writer.write_collection_of_object_values('multiValueExtendedProperties', @multi_value_extended_properties)
      writer.write_string_value('parentFolderId', @parent_folder_id)
      writer.write_date_time_value('receivedDateTime', @received_date_time)
      writer.write_collection_of_object_values('replyTo', @reply_to)
      writer.write_object_value('sender', @sender)
      writer.write_date_time_value('sentDateTime', @sent_date_time)
      writer.write_collection_of_object_values('singleValueExtendedProperties', @single_value_extended_properties)
      writer.write_string_value('subject', @subject)
      writer.write_collection_of_object_values('toRecipients', @to_recipients)
      writer.write_object_value('uniqueBody', @unique_body)
      writer.write_string_value('webLink', @web_link)
    end

    ##
    ## Gets the singleValueExtendedProperties property value. The collection of single-value extended properties defined for the message. Nullable.
    ## @return a single_value_legacy_extended_property
    ##
    attr_accessor :single_value_extended_properties

    ##
    ## Sets the singleValueExtendedProperties property value. The collection of single-value extended properties defined for the message. Nullable.
    ## @param value Value to set for the singleValueExtendedProperties property.
    ## @return a void
    ##

    ##
    ## Gets the subject property value. The subject property
    ## @return a string
    ##
    attr_accessor :subject

    ##
    ## Sets the subject property value. The subject property
    ## @param value Value to set for the subject property.
    ## @return a void
    ##

    ##
    ## Gets the toRecipients property value. The toRecipients property
    ## @return a recipient
    ##
    attr_accessor :to_recipients

    ##
    ## Sets the toRecipients property value. The toRecipients property
    ## @param value Value to set for the toRecipients property.
    ## @return a void
    ##

    ##
    ## Gets the uniqueBody property value. The uniqueBody property
    ## @return a item_body
    ##
    attr_accessor :unique_body

    ##
    ## Sets the uniqueBody property value. The uniqueBody property
    ## @param value Value to set for the uniqueBody property.
    ## @return a void
    ##

    ##
    ## Gets the webLink property value. The webLink property
    ## @return a string
    ##
    attr_accessor :web_link

    ##
    ## Sets the webLink property value. The webLink property
    ## @param value Value to set for the webLink property.
    ## @return a void
    ##
  end
end
