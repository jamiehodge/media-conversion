require "./lib/media/conversion"

Media::Conversion::Controllers::Base.children.each do |child|
  map "/%s" % child.namespace do
    run child
  end
end
