class InstrumentsController < ApplicationController

  get '/instruments' do
    if logged_in?
      @instruments = current_user.instruments
      erb :'/instruments/instruments'
    else
      flash[:message] = "** You must be logged in to view instruments. **"
      redirect to "/login"
    end
  end

  post '/instruments' do
      instrument = current_user.instruments.build(name: params[:name], description: params[:description])
      if instrument.save
        flash[:message] = "You successfully created an instrument!"
        redirect '/instruments'
      else
        flash[:message] = "You need to name your instrument!"
        redirect '/new'
      end
  end

  get '/new' do
    if !logged_in?
      flash[:message] = "** You must be logged in to create instruments. **"
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
      flash[:message] = "** You must be logged in to view instruments. **"
      redirect to '/login'
    end
  end

  get '/instruments/:id/edit' do
    @instrument = Instrument.find_by_id(params[:id])
    if logged_in?
      erb :'/instruments/edit'
      else
      flash[:message] = "** You must be logged in to edit instruments. **"
      redirect to '/login'
    end
  end

  patch '/instruments/:id' do
    instrument = Instrument.find_by_id(params[:id])
    if params[:description] && params[:name]!= ""
      instrument.description = params[:description]
      instrument.name = params[:name]
      instrument.save
      flash[:message] = "You successfully edited an instrument!"
      redirect '/instruments'
    else
      redirect "/instruments/#{instrument.id}/edit"
    end
  end

  delete '/instruments/:id/delete' do
    @instrument = Instrument.find_by_id(params[:id])
    if @instrument.user_id == current_user.id && @instrument.delete
      flash[:message] = "You successfully deleted an instrument."
      redirect '/instruments'
    else
      redirect "/instruments/#{@instrument.id}"
    end
  end

end
