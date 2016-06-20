class InstrumentsController < ApplicationController

  get '/instruments' do
    @instruments = Instrument.all
    if logged_in?
      erb :'/instruments/instruments'
      # flash[:message] = "You must be logged in to view instruments."
    else
      redirect to "/login"
    end
  end

  post '/instruments' do
    # @user = current_user
    # @instrument = Instrument.create(name: params[:name], description: params[:description], user_id: session[:user_id])
    #   if @instrument.save
    #     redirect to "/instruments/#{@instrument.id}"
    #   else
    #     redirect to '/new'
    #   end
    #
      if params[:name] != ""
        tweet = Instrument.create(name: params[:name], description: params[:description], user_id: session[:user_id])
        redirect '/instruments'
      else
        redirect '/instruments/new'
      end
  end

  get '/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/instruments/new'
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

  get '/instruments/:id/edit' do
    @instrument = Instrument.find_by_id(params[:id])
    if logged_in?
      erb :'/instruments/edit'
      else
      redirect to '/login'
    end
  end

  patch '/instruments/:id' do
    instrument = Instrument.find(params[:id])
    if params[:description] && params[:name]!= ""
      instrument.description = params[:content]
      instrument.name = params[:name]
      instrument.save
      redirect '/instruments'
    else
      redirect "/instruments/#{instrument.id}/edit"
    end
  end

  delete 'instruments/:id/delete' do
    instrument = Instrument.find(params[:id])
    if current_user.instruments.include?(instrument)
      instrument.delete
    end
    redirect to "/instruments"
  end

end
