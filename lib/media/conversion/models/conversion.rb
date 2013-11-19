require_relative "base"

module Media
  module Conversion
    module Models
      class Conversion < Base
        many_to_one :converter
        many_to_one :state

        storable
        transitionable

        def extension
          converter.extension
        end

        def before_validation
          self.state ||= State::PENDING
          validates_uuid [:converter_id, :state_id, :resource_id]
          super
        end

        def validate
          super
          validates_transition :state_id
        end

        def after_create
          super
          Tasks::Conversion.enqueue(id: id)
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

        def state_id_transitions
          {
            nil                 => [ State::PENDING.id ],
            State::PENDING.id   => [ State::RUNNING.id ],
            State::RUNNING.id   => [ State::COMPLETED.id, State::FAILED.id ],
            State::COMPLETED.id => [],
            State::FAILED.id    => []
          }
        end
      end
    end
  end
end
