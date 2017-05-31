module SessionsHelper
  #logs in the given user
  def log_in(user)
    if user.activated?
      session[:user_id] = user.id
    end
  end
  # remembers a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #returns the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
      # cookies.signed is a method that can read cookies that have been signed by the apps secrets.secret_key_base
    elsif (user_id = cookies.signed[:user_id])
      # The tests still pass, so this branch is currently untested.
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    # current_user == user
    user == current_user
  end

  #forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  #returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  #logs out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
    # Redirects to stored location (or to the default)
    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end
  # Stores the URL trying to be accessed.
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end
  end
  # this sessions_helper is responsible for remembering the user.
