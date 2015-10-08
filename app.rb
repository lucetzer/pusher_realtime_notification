require 'sinatra/base'
require 'pusher'

class Notifications < Sinatra::Base

  pusher = Pusher::Client.new({
          app_id: ENV['PUSHER_ID'],
          key: ENV['PUSHER_KEY'],
          secret: ENV['PUSHER_SECRET']
  })

  get '/' do
    erb :index
  end

  post '/notification' do
    message = params[:message]
    pusher.trigger('notifications', 'new_notification', {
      message: message
    })
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
