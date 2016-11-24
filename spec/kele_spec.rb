require 'spec_helper'
require 'kele'
require 'rubygems'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :httparty # or :fakeweb
end

describe Kele do
  pending "write it"

  VCR.use_cassette("synopsis") do
    response = Net::HTTP.get_response(URI('http://www.iana.org/domains/reserved'))
    assert_match /Example domains/, response.body
  end
  
end
