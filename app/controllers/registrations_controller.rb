class RegistrationsController < ApplicationController
   # instantiates new user
   def new
     @user = Users.new
   end
   # def create
   #   @user = Users.new(user_params)
   #   if @user.save
   #   # stores saved user id in a session
   #     session[:user_id] = @user.id
   #     redirect_to root_path, notice: 'Successfully created account'
   #   else
   #     render :new
   #   end
   # end
   def create
  @user = Users.new(user_params)
  if @user.save
    WelcomeMailer.with(user: @user).welcome_email.deliver_now
    # deliver_now is provided by ActiveJob.
    session[:user_id] = @user.id
    redirect_to root_path, notice: 'Successfully created account'
  else
    render :new
  end
end
   private
   def user_params
     # strong parameters
     params.require(:users).permit(:email, :password, :password_confirmation)
   end
 end
