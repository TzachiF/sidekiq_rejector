module Helpers
  # Validates if a reject value is part of the msg
  class Validator
    attr_reader :reject_hash
    
    KEYS = [:queue, :worker, :method]
    
    def initialize(rejecte_values_json)
      @reject_hash = JSON.parse rejecte_values_json
    end

    def reject?(msg)
      KEYS.each do |key|
        value = reject_hash[key] || reject_hash[key.to_s]
        result = reject_section value, msg
        return true if result
      end
      false
    end

    private

    def reject_section(data_array, msg)
      return false if data_array.nil? || data_array.empty?
      data_array.each do |value|
        return true if msg.include? value
      end 
    end
  end
end