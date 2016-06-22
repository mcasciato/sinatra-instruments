class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/instruments'
    else
      erb :'/users/signup'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  post '/signup' do
    if params[:password] == ""
      flash[:message] = "**You must create a password.**"
      redirect '/signup'
    end
    user = User.new(params)
    if user.username != "" && user.email != ""
      user.save
      session[:user_id] = user.id
      flash[:message] = "You successfully created a user!"
      redirect to "/instruments"
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/instruments'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/instruments"
    else
      erb :'/users/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "You successfully logged out."
      redirect '/login'
    else
      redirect '/'
    end
  end

end
