require_relative "base"

module Media
  module Conversion
    module Controllers
      class Converters < Base

        set(:model)   { Models::Converter }
        set(:policy)  { Web::Policies::Static }

        static
      end
    end
  end
end
