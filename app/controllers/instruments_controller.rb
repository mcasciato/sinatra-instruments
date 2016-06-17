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
end
