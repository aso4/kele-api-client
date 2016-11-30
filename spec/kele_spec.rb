require 'spec_helper'

describe Kele do
  let(:kele_valid_instance) { Kele.new(ENV['VALID_USERNAME'], ENV['VALID_PASSWORD']) }
  let(:kele_invalid_instance) { Kele.new('not', 'valid') }

  describe '#call_api' do
    it 'has an auth token' do
      VCR.use_cassette('bloc_api_call', record: :new_episodes) do
        expect(kele_valid_instance.instance_variable_get('@auth_token')).to_not be_nil
      end
    end

    it 'logs the user in' do
      VCR.use_cassette('bloc_api_call', record: :new_episodes) do
        expect(kele_valid_instance.get_me['slug']).to eq ENV['SLUG']
      end
    end

    it "gets mentor availability" do
      VCR.use_cassette('bloc_api_call', record: :new_episodes) do
        puts kele_valid_instance.get_mentor_availability(ENV["VALID_MENTOR_ID"])[0]['id']
  		  expect(kele_valid_instance.get_mentor_availability(ENV["VALID_MENTOR_ID"])[0]['week_day']).to eq 1
      end
  	end

    it "gets a roadmap" do
      VCR.use_cassette('bloc_api_call', record: :new_episodes) do
  		  expect(kele_valid_instance.get_roadmap(37)["id"]).to eq 37
      end
  	end

  	it "gets a checkpoint" do
      VCR.use_cassette('bloc_api_call', record: :new_episodes) do
  		  expect(kele_valid_instance.get_checkpoint(2106)["id"]).to eq 2106
      end
  	end
  end
end
