class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  post '/owners' do
    @owner = Owner.create(params[:owner])
    if !@params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    @owner.save

    redirect "owners/#{@owner.id}"
  end

  post '/owners/:id' do
    @owner = Owner.find(params[:id])
    @owner.update(params[:owner])
    if !@params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    @owner.save

    redirect "owners/#{@owner.id}"
  end
end
