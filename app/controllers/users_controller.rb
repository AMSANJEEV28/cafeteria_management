class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :ensure_user_logged_in, only: [:new, :create]
  before_action :ensure_owner_logged_in, only: [:index, :removeAsClerk, :makeAsClerk, :createClerk, :newClerk]

  def index
    @users = User
    render "index"
  end

  def new
    render "users/new"
  end

  def create
    user_role = "customer"
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

  def removeAsClerk
    id = params[:id]
    user = User.find(id)
    user.role = "customer"
    user.save
    redirect_to users_path
  end

  def makeAsClerk
    id = params[:id]
    user = User.find(id)
    user.role = "clerk"
    user.save
    redirect_to users_path
  end

  def newClerk
    render "/users/new_clerk"
  end

  def createClerk
    user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_no: params[:phone_no],
      password: params[:password],
      role: params[:user_role],
    )

    if user.save
      flash[:error] = "#{params[:user_role]} Hurray !! Account #{params[:first_name] + + params[:last_name]} is created !! "
      repost("/carts")
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to "/users/new"
    end
  end
end