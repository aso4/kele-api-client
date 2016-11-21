require 'httparty'

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


end
