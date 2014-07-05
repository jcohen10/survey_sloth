helpers do

  def current_user
    @user ||= User.find(session[:user_id])
  end

  def logged_in?
    current_user
  end


  def display_errors
    if session[:error]
      @error = session[:error]
      session[:error] = nil
    end
  end

end
