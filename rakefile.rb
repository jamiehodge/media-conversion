require "rake/testtask"
require "media/persistence/rake"
require "media/queue/rake"

Rake::TestTask.new do |t|
  t.libs << "lib" << "test"
  t.test_files = FileList["test/**/test_*.rb"]
end

namespace :queue do

  desc "environment"
  task :environment do
    require_relative "lib/media/conversion/tasks"
  end
end
