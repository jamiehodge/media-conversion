require "media/client"
require "media/ffmpeg"
require "tempfile"

module Media
  module Conversion
    module Tasks
      class Conversion

        attr_reader :id, :model, :processor, :resourcer

        def initialize(params = {})
          @id        = params.fetch(:id)
          @model     = params.fetch(:model) { Models::Conversion }
          @processor = params.fetch(:processor) { FFMPEG::Conversion }
          @resourcer = options.fetch(:resourcer) { Client::Service::Resource.new(ENV["RESOURCE_URL"]) }
        end

        def call
          Tempfile.open(["conversion", converter.extension]) do |temp|
            conversion.running!

            result = processor.call(command(temp.path)) do |progress|
              conversion.update(progress: progress.to_f)
            end

            if result.success?
              conversion.update(file: temp)
              conversion.completed!
            else
              conversion.failed!
            end
          end
        rescue => e
          logger.error("#{e.message} (#{e.class}): #{e.backtrace.join("\n")}")
          conversion.failed!
        end

        private

        def conversion
          @conversion ||= model[id]
        end

        def converter
          conversion.converter
        end

        def input
          resource[:file][:url]
        end

        def resource
          @resource ||= resourcer.show(conversion.resource_id)
        end

        def command(output)
          converter.command.map {|segment| ERB.new(segment).result(binding) }
        end
      end
    end
  end
end
