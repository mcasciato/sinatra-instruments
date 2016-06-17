class InstrumentsController < ApplicationController

  get '/instruments' do
    if !logged_in?
      redirect to '/login'
      # flash[:message] = "You must be logged in to view instruments."
    else
      @instruments = Instrument.all
      erb :'/instruments/instruments'
    end
  end

  get '/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/instruments/new'
    end
  end

  post '/instruments' do
    @user = current_user
    @instrument = Instrument.create(name: params[:name], description: params[:description], user_id: session[:user_id])
      if @instrument.save
        redirect to "/instruments/#{@instrument.id}"
      else
        redirect to '/new'
      end
  end

  get '/instruments/:id' do
    @instrument = Instrument.find_by_id(params[:id])
    if logged_in?
      erb :'/instruments/show'
    else
      redirect to '/login'
    end
  end
end
