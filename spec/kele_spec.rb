require 'spec_helper'

describe Kele do

  let(:kele_valid_instance) { Kele.new(ENV["VALID_USERNAME"], ENV["VALID_PASSWORD"]) }
  let(:kele_invalid_instance) { Kele.new("not", "valid") }
  # puts "putting!!!!"
  # puts ENV['VALID_USERNAME']
  # puts Figaro.env.valid_username
  # puts ENV["VALID_PASSWORD"]
  # puts Figaro.env.valid_password
  # puts '123'

  describe '#call_api' do
     it 'has an auth token' do
       VCR.use_cassette('bloc_api_call') do
          response = kele_valid_instance
          expect(response.instance_variable_get('@auth_token')).to_not be_nil
       end
     end

     it 'responds to auth_token' do
       VCR.use_cassette('bloc_api_call') do
         response = kele_valid_instance.get_me
       	 expect(response["slug"]).to eq ENV["KELE_SLUG"]
       end
     end

     it 'logs the expected user in' do
       VCR.use_cassette('bloc_api_call', :record => :new_episodes) do
       		response = kele_valid_instance.get_me
       		expect(response["slug"]).to eq ENV["KELE_SLUG"]
       end
   	end
  end
end
