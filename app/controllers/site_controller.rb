class SiteController < ApplicationController
  def index
    @new_user = User.new
    @users = User.all

    redirect_to events_path if current_user

  end


  def login
    begin
      @user = User.find_by(email: params[:email])
      if @user and @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_url
      else
        redirect_to root_url, notice: 'Email or password incorrect!'
      end
    rescue Exception => e
      redirect_to root_url, notice: 'Please register!'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_url
  end
end
