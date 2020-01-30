class HelloController < ApplicationController
  def index
    message = params[:message] || 'hello, nuxt on rails'
    render json: { message: message }, status: :ok and return
  end
end
