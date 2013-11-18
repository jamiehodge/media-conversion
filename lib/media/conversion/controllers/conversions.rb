require_relative "base"

module Media
  module Conversion
    module Controllers
      class Conversions < Base

        set(:model)  { Models::Conversion }
        set(:policy) { Policies::Conversion }

        index
        create
        guard
        show
        destroy
      end
    end
  end
end
