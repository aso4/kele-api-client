require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap
  base_uri 'https://www.bloc.io/api/v1'

  def initialize email, password
    response = self.class.post '/sessions', body: { email: email, password: password }

    if response['auth_token'].nil?
      raise ArgumentError.new 'Invalid email and/or password.'
    else
      @auth_token = response['auth_token']
    end
  end

  def get_me
    response = self.class.get '/users/me', headers: { 'content_type' => 'application/json', 'authorization' => @auth_token }
    JSON.parse response.body
  end

  def get_mentor_availability mentor_id
    response = self.class.get "/mentors/#{mentor_id}/student_availability", headers: { 'content_type' => 'application/json', 'authorization' => @auth_token }
		JSON.parse response.body
  end

  def get_messages page
    response = self.class.get "/message_threads", headers: { 'content_type' => 'application/json', 'authorization' => @auth_token }, query: { page: page }
    JSON.parse response.body
  end

  def create_message sender, recipient_id, subject, stripped_text, token = ""
    if token.empty?
      options = { sender: sender, recipient_id: recipient_id, subject: subject, 'stripped-text' => stripped_text }
    else
      options = { sender: sender, recipient_id: recipient_id, subject: subject, 'stripped-text' => stripped_text, token: token }
    end
    response = self.class.post '/messages', headers: { 'content_type' => 'application/json', 'authorization' => @auth_token }, query: options
    JSON.parse response.body
  end

  def create_submission checkpoint_id, assignment_branch, assignment_commit_link, comment
    options = { checkpoint_id: checkpoint_id, assignment_branch: assignment_branch, assignment_commit_link: assignment_commit_link, comment: comment }
    response = self.class.post '/checkpoint_submissions', headers: { 'content_type' => 'application/json', 'authorization' => @auth_token }, query: options
    JSON.parse response.body
  end
end
