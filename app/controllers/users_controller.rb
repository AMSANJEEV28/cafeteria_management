class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :ensure_user_logged_in
  
    def new
      render "users/new"
    end
  
    def create
      user_role = "user"
      user = User.new(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        phone_no: params[:phone_no],
        password: params[:password],
        role: user_role,
      )
  
      if user.save
        session[:current_user_id] = user.id
        repost("/carts")
      else
        flash[:error] = user.errors.full_messages.join(", ")
        redirect_to "/users/new"
      end
    end
  end