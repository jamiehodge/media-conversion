require_relative "base"

module Media
  module Conversion
    module Models
      class Converter < Base
        one_to_many :conversions

        dataset_module do

          def type(value)
            where(value.sub(%r{/.+$}, "/*") =>
              Sequel.pg_array_op(:types).any)
          end
        end
      end
    end
  end
end
