require 'spec_helper'

describe Kele do

  let(:kele_valid_instance) { Kele.new(ENV["VALID_USERNAME"], ENV["VALID_PASSWORD"]) }
  let(:kele_invalid_instance) { Kele.new("not", "valid") }

  describe '#call_api' do
     it 'has an auth token' do
       VCR.use_cassette('bloc_api_call', :record => :new_episodes) do
          kele = kele_valid_instance
          expect(kele.instance_variable_get('@auth_token')).to_not be_nil
       end
     end

     it 'signs the user in' do
       VCR.use_cassette('bloc_api_call') do
         kele = kele_valid_instance
         kele.inspect
       	 expect(kele.get_me["slug"]).to eq ENV["SLUG"]
       end
     end

     it 'logs the expected user in' do
       VCR.use_cassette('bloc_api_call') do
       		response = :kele_valid_instance
       		expect(response.get_me["slug"]).to eq ENV["KELE_SLUG"]
       end
   	end
  end
end
