require 'fileutils'

task default: :test

task :test do
  ruby "test/integration_tests/test_runner.rb"
end

namespace :test do
  task :purge do
    FileUtils.rm_r("test/integration_tests/.temp")
  end
end
