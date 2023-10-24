class UsersController <ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    @user = User.find(params[:id])
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
        if user.admin?
          redirect to admin_dashboard_path
        elsif user.manager?
          redirect_to user_path(user)
        else
          redirect_to user_path(user)
        end
    else 
      flash[:error] =  "Your credentials are bad.  Try again."
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