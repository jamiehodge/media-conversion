require_relative "base"

module Media
  module Conversion
    module Models
      class State < Base
        one_to_many :conversions

        PENDING   = first(name: "pending")
        RUNNING   = first(name: "runnning")
        COMPLETED = first(name: "completed")
        FAILED    = first(name: "failed")
      end
    end
  end
end
