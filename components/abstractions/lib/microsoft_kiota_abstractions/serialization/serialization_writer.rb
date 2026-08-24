# frozen_string_literal: true

module MicrosoftKiotaAbstractions
  module SerializationWriter
    def write_string_value(_key, _value)
      raise NotImplementedError
    end

    def write_boolean_value(_key, _value)
      raise NotImplementedError
    end

    def write_number_value(_key, _value)
      raise NotImplementedError
    end

    def write_float_value(_key, _value)
      raise NotImplementedError
    end

    def get_date_value(_key, _value)
      raise NotImplementedError
    end

    def write_guid_value(_key, _value)
      raise NotImplementedError
    end

    def write_date_value(_key, _value)
      raise NotImplementedError
    end

    def write_time_value(_key, _value)
      raise NotImplementedError
    end

    def write_date_time_value(_key, _value)
      raise NotImplementedError
    end

    def write_duration_value(_key, _value)
      raise NotImplementedError
    end

    def write_collection_of_primitive_values(_key, _value)
      raise NotImplementedError
    end

    def write_collection_of_object_values(_key, _value)
      raise NotImplementedError
    end

    def write_enum_value(_key, _value)
      raise NotImplementedError
    end

    def get_serialized_content
      raise NotImplementedError
    end

    def write_additional_data(_type)
      raise NotImplementedError
    end

    def write_any_value(_key, _value)
      raise NotImplementedError
    end

    def write_object_value(_key, _value, *_additional_values_to_merge)
      raise NotImplementedError
    end
  end
end
