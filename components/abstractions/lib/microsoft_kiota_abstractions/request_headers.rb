# frozen_string_literal: true

module MicrosoftKiotaAbstractions
  class RequestHeaders
    def initialize
      @headers = {}
    end

    def add(key, value)
      if key.nil? || key.empty? || value.nil? || value.empty?
        raise ArgumentError, 'key and value cannot be nil or empty'
      end

      existing_value = @headers[key]
      if existing_value.nil?
        @headers[key] = if value.is_a?(Array)
                          value
                        else
                          [value.to_s]
                        end
      elsif value.is_a?(Array)
        @headers[key] = existing_value | value
      else
        existing_value << value.to_s
      end
    end

    def try_add(key, value)
      if key.nil? || key.empty? || value.nil? || value.empty?
        raise ArgumentError, 'key and value cannot be nil or empty'
      end

      existing_value = @headers[key]
      return false unless existing_value.nil? || existing_value.empty?

      @headers[key] = [value.to_s]
      true
    end

    def get(key)
      raise ArgumentError, 'key cannot be nil or empty' if key.nil? || key.empty?

      @headers[key]
    end

    def remove(key)
      raise ArgumentError, 'key cannot be nil or empty' if key.nil? || key.empty?

      @headers.delete(key)
    end

    def clear
      @headers.clear
    end

    def get_all
      @headers
    end
  end
end
