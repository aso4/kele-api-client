require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1/sessions'

  def initialize email, password
    response = self.class.post 'https://www.bloc.io/api/v1/sessions', body: {email: email, password: password}

    if response['auth_token'].nil?
      raise ArgumentError.new 'Invalid email and/or password.'
    else
      @auth_token = response['auth_token']
    end
  end

  def get_me
    url = 'https://www.bloc.io/api/v1/users/me'
    response = self.class.get(url, headers: { "content_type" => 'application/json', "authorization" => @auth_token })
    testthis = JSON.parse(response.body)
    end
end
