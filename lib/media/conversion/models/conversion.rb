require_relative "base"

module Media
  module Conversion
    module Models
      class Conversion < Base
        many_to_one :converter
        many_to_one :state

        storable

        def converter
          Converter[converter_id] if converter_id
        end

        def extension
          converter.extension
        end

        def before_validation
          self.state ||= State::PENDING
          validates_uuid [:converter_id, :state_id, :resource_id]
        end

        def after_create
          super
          Tasks::Conversion.new(id, resourcer: MockService).call
        end

        def running!
          update(state: State::RUNNING)
        end

        def completed!
          update(state: State::COMPLETED)
        end

        def failed!
          update(state: State::FAILED)
        end
      end
    end
  end
end

module MockService
  extend self

  def show(id)
    { file: { url: "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4"}}
  end
end
