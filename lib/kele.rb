require 'httparty'

class Kele
  include HTTParty
  base_uri "https://www.bloc.io/api/v1/"

  def initialize(email, password)
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: {"email": email, "password": password})

  end
end
