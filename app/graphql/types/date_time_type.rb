module Types
    class DateTimeType < GraphQL::Schema::Scalar
      description "An ISO 8601-encoded datetime"
  
      def self.coerce_input(input_value, _context)
        Time.iso8601(input_value)
      rescue ArgumentError
        nil
      end
  
      def self.coerce_result(ruby_value, _context)
        ruby_value.iso8601
      end
    end
  end
  