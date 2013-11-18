require_relative "base"

module Media
  module Conversion
    module Policies
      class Conversion < Base

        def fields
          %w(converter_id resource_id)
        end
      end
    end
  end
end
