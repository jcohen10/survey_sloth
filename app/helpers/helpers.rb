helpers do

  def display_errors
    if session[:error]
      @error = session[:error]
      session[:error] = nil
    end
  end

end
