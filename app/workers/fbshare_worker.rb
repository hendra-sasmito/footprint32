class FbshareWorker
  include Sidekiq::Worker
  
  def perform(user_id, content, name, link)
    #graph = Koala::Facebook::API.new(token.token)
    fb_user = User.find_by_id(user_id)
    if !fb_user.nil?
      token = fb_user.authentications.find_by_provider("facebook")
      if !token.nil?
	graph = Koala::Facebook::API.new(token.token)
	if !graph.nil?
	  graph.put_wall_post(content, {:name => name, :link => link})
	end
      end
    end
  end
end

