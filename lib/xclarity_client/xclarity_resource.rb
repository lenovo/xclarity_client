module XClarityClient
  module Resource
    def build_resource(attributes)
      attributes.each do |key, value|
        begin
          value = value.gsub("\u0000", '') if value.is_a?(String)
          send("#{key}=", value)
        rescue
          $log.warn("UNEXISTING ATTRIBUTES FOR #{self.class}: #{key}") unless defined?(Rails).nil?
        end
      end
    end

    def to_hash
      hash = {}
      instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
      hash
    end
  end
end
