require 'openssl'

class SessionController < ApplicationController
	def login
		@is_login = true
		@username = params[:username]	# add .strip?
#		Rails.logger.warn("KEY=[#{! session[:key].nil?}]   PWD=[#{params[:login][:encrypted_pwd]}]")
		if session[:key].nil? then
			@message = flash[:notice] || ''
			return to_show_login
		end
		# encrypted_pwd will normally never be tripped because of on-page Javascript
		if is_blank?(params[:username]) or is_blank?(params[:login][:encrypted_pwd]) then
			@error = 'You must enter both a user name and password' if flash[:notice].nil?
			return to_show_login
		end
		begin
			@user = Login.find_by_username(@username)
			raise 'Unknown user' if @user.nil?
		rescue
			@error = 'You must enter a correct user name and password'
			return to_show_login
		end
		key = OpenSSL::PKey::RSA.new(session[:key])
		pwd = key.private_decrypt(Base64.decode64(params[:login][:encrypted_pwd]))
		hashed = OpenSSL::Digest::SHA1.new([@user.salt,pwd].to_s).hexdigest
		if(@user.encrypted_pwd == hashed) then
			# authenticated
			session[:current_user_account] = @user.account
			# If forwarding page, go to it.
			if session[:fwd_to]
				redirect_to session[:fwd_to]
				session[:fwd_to] = nil
			else
				flash[:notice] = "You are now logged in.  You can create recipes."
				redirect_to recipes_path
			end
			return
		else
			# reshow the page
			@error = 'You must enter a correct user name and password'
		end

		to_show_login
	end
	
	def logout
		session[:current_user_account] = nil
		@is_logout = true
		@message = 'You have been logged out'
		
		to_show_login
		render :action => 'login'
	end
end
