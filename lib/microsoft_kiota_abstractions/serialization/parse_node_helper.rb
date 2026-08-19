module MicrosoftKiotaAbstractions
  class ParseNodeHelper
    def self.merge_deserializers_for_intersection_wrapper(*targets)
      result = {}
      targets.each do |target|
        result.merge!(target.get_field_deserializers) unless target.nil?
      end
      result
    end
  end
end
