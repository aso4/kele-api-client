module Roadmap
  def get_roadmap roadmap_id
    response = self.class.get "/roadmaps/#{roadmap_id}", headers: { 'content_type' => 'application/json', 'authorization' => @auth_token }
    JSON.parse response.body
  end

  def get_checkpoints checkpoint_id
    response = self.class.get "/checkpoints/#{checkpoint_id}", headers: { 'content_type' => 'application/json', 'authorization' => @auth_token }
    JSON.parse response.body
  end
end
