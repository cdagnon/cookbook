class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def is_blank?(value)
  	  value.nil? || (value.is_a?(String) && value.strip().empty?)
  end
  
  def is_logged_in
	! session[:current_user_account].nil?
  end
  
  def verify_logged_in_or_redirect
	if ! is_logged_in() then
		session[:fwd_to] = params[:url]
#		flash[:notice] = "You must register and be logged in to do that."
		redirect_to login_path
		return false;
	end
  end

  def setup_user_if_logged_in
  	  if is_logged_in() then
  	  	  @current_user = session[:current_user_account]
  	  end
  end
  
	# Helper for login and account creation
	def to_show_login
		# Password strategy		
		key = OpenSSL::PKey::RSA.new(1024)
		@public_modulus  = key.public_key.n.to_s(16)
		@public_exponent = key.public_key.e.to_s(16)
		session[:key] = key.to_pem
	end
end
