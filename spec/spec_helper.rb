require 'bundler/setup'
Bundler.setup

require 'kele' # and any other gems you need
require 'vcr_setup'
require 'figaro'
# puts YAML.load(File.read(File.expand_path('../../config/application.yml', __FILE__))).class

RSpec.configure do |config|
  # some (optional) config here
end
