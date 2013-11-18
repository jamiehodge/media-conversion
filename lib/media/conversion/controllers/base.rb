require "media/web"

module Media
  module Conversion
    module Controllers
      class Base < Web::Controllers::Base
        set(:root) { File.expand_path("../../", __FILE__) }
      end
    end
  end
end
