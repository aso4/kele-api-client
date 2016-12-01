require 'spec_helper'

describe Kele do
  let(:kele_valid_instance) { Kele.new(ENV['VALID_USERNAME'], ENV['VALID_PASSWORD']) }
  let(:kele_invalid_instance) { Kele.new('not', 'valid') }

  describe '#call_api' do
    it 'has an auth token' do
      VCR.use_cassette('retrieve_auth_token', record: :new_episodes) do
        expect(kele_valid_instance.instance_variable_get('@auth_token')).to_not be_nil
      end
    end

    it 'logs the user in' do
      VCR.use_cassette('get_me_call', record: :new_episodes) do
        expect(kele_valid_instance.get_me['slug']).to eq ENV['SLUG']
      end
    end

    it "gets mentor availability" do
      VCR.use_cassette('get_mentor_availability_call', record: :new_episodes) do
        #puts kele_valid_instance.get_mentor_availability(ENV["VALID_MENTOR_ID"])[0]['id']
  		  expect(kele_valid_instance.get_mentor_availability(ENV["VALID_MENTOR_ID"])[0]['week_day']).to eq 4
      end
  	end

    it "gets a roadmap" do
      VCR.use_cassette('get_roadmap_call', record: :new_episodes) do
  		  expect(kele_valid_instance.get_roadmap(37)["id"]).to eq 37
      end
  	end

  	it "gets a checkpoint" do
      VCR.use_cassette('get_checkpoint_call', record: :new_episodes) do
  		  expect(kele_valid_instance.get_checkpoint(2106)["id"]).to eq 2106
      end
  	end

    it "gets the specified page of messages" do
      VCR.use_cassette('get_messages_call', record: :new_episodes) do
        expect(kele_valid_instance.get_messages(1)).not_to be_nil
      end
    end

    it "sends messages without token" do
      VCR.use_cassette('create_message_no_token_call', record: :new_episodes) do
        me = kele_valid_instance.get_me
    		subject = "Sent from Kele RSpec Test"
    		text = "This message is sent from my rspec test."
    		response = kele_valid_instance.create_message me["email"], me["current_enrollment"]["mentor_id"], subject, text
    		expect(response["success"]).to eq true
      end
    end

    it "sends messages with a token" do
      VCR.use_cassette('create_message_token_call', record: :new_episodes) do
        me = kele_valid_instance.get_me
    		subject = "Sent from Kele RSpec Test"
    		text = "This is another message sent from my rspec test. This time it is attaching to a current message thread."
    		token = ENV["MESSAGE_TOKEN"]
    		response = kele_valid_instance.create_message me["email"], me["current_enrollment"]["mentor_id"], subject, text, token
    		expect(response["success"]).to eq true
      end
    end
  end
end
