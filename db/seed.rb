require_relative "../lib/media/conversion"

module Media
  Persistence::DB.transaction do

    %w(pending running completed failed).each do |name|
      Conversion::Models::State.find_or_create(name: name)
    end

    Conversion::Models::Converter.find_or_create(name: "mp4") {|c|
      c.extension = ".mp4"
      c.types = ["video/*"]
      c.command = ["ffmpeg", "-y", "-i", "<%= input %>", "<%= output %>"]
    }

    Conversion::Models::Converter.find_or_create(name: "webm") {|c|
      c.extension = ".webm"
      c.types = ["video/*"]
      c.command = ["ffmpeg", "-y", "-i", "<%= input %>", "<%= output %>"]
    }

    Conversion::Models::Converter.find_or_create(name: "mp3") {|c|
      c.extension = ".mp3"
      c.types = ["audio/*", "video/*"]
      c.command = ["ffmpeg", "-y", "-i", "<%= input %>", "<%= output %>"]
    }
  end
end
