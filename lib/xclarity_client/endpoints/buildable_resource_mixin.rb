module XClarityClient
  module Endpoints
    #
    # A Buildable Resource can build itself from some formats
    # of data (ex: Hashes) and also can transform itself in
    # other formats of data.
    #
    module BuildableResourceMixin
      #
      # Builds the resource from a Hash.
      #
      # @param [Hash] attributes - contains the values
      #   that will be assign to the resource properties
      #
      def build_resource!(attributes)
        attributes.each { |key, value| set_attr(key, value) }
      end

      #
      # Converts the resource into a Hash.
      #
      # @return [Hash] containing the resource properties values
      #
      def to_hash
        hash = {}
        instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
        hash
      end

      private

      #
      # Sets the value to the attribute that corresponds to the key
      #
      # @param [String] key   - name of the resource attribute
      # @param [String] value - value to be set
      #
      def set_attr(key, value)
        value = format_value(value)
        key   = format_key(key)
        send("#{key}=", value)
      rescue
        unless defined?(Rails).nil?
          $lxca_log.info(
            'XClarityClient::Endpoints::BuildableResourceMixin',
            "UNEXISTING ATTRIBUTES FOR #{self.class}: #{key}"
          )
        end
      end

      #
      # Removes null characters if the value is a String
      #
      def format_value(value)
        value.is_a?(String) ? value.gsub("\u0000", '') : value
      end

      #
      # Formats the key to the attributes pattern (replace '-' with '_')
      #
      def format_key(key)
        key.to_s.gsub("-","_")
      end
    end
  end
end
