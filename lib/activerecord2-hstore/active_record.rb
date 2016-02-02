module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter < AbstractAdapter
      def quote_with_hstore(value, column=nil)
        if column && column.sql_type == "hstore" then
          # Use a hstore syntax such that each key and value can be escaped separately with a postgres quote function.
          #   hstore(ARRAY[['c','3'],['d','4']])
          result = 'hstore(ARRAY['
          case
          when value.kind_of?(Hash) then
            result << value.map do |key,value|
              quoted_key = quote_without_hstore(key.try(:to_s))
              quoted_value = quote_without_hstore(value.try(:to_s))
              format('[%s,%s]', quoted_key, quoted_value)
            end.join(",")
          when value.kind_of?(String) then
            return quote_without_hstore(value, column)
          else
            raise "Unsupported data type #{value.type.inspect}, expected Hash"
          end
          result << ']::text[])'
          return result
        else
          return quote_without_hstore(value, column)
        end
      end

      alias_method_chain :quote, :hstore
    end
  end
end
