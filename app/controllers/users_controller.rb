class UsersController <ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      flash[:error] = "Sign in before going to your dashboard"
      redirect_to "/"
    end
  end 

  def create 
    new_user = User.create(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      redirect_to user_path(new_user)
    else  
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end 

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else 
      flash.now[:error] =  "Your credentials are bad.  Try again."
      render :login_form
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to root_path
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 