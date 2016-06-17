class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else
      erb :'instruments/instruments'
    end
  end

  get '/login' do
  if logged_in?
    redirect to '/instruments'
  else
    erb :'/users/login'
  end
end

end
