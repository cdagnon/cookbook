require 'openssl'

class AccountsController < ApplicationController
	before_filter :setup_user_if_logged_in
	before_filter :verify_logged_in_or_redirect, :except => [:new, :create]

  # GET /accounts
  # GET /accounts.xml
  def index
    @accounts = Account.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.xml
  def show
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.xml
  def new
  	@login = Login.new
	@account = Account.new( :language => 'English', :location_country => 'U.S.A.', :login => Login.new )
	to_show_login		# makes the encryption keys

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/1/edit
  def edit
  	  flash[:notice] = 'Currently no editing is allowed.'
  	  redirect_to recipes_path
  end
  def original_edit
  	  @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.xml
  def create
#  	  logger.warn("PARAMS=#{params.inspect}");
  	  
    @login		= Login.new(params[:login])
    @account	= Account.new(params[:account])
    @account.registered_at = DateTime.now
    @account.login = @login
	if session[:key].nil? or params[:login][:encrypted_pwd].nil? then
		flash[:notice] = 'You must enter a user name and password to enter'
#		return to_show_login
		redirect_to new
		return
	end

	# Process the password and create a salt value
	key = OpenSSL::PKey::RSA.new(session[:key])
	pwd = key.private_decrypt(Base64.decode64(@login.encrypted_pwd))
	@login.salt = OpenSSL::Digest::SHA1.new( OpenSSL::Random.random_bytes(256)).hexdigest
	@login.encrypted_pwd = OpenSSL::Digest::SHA1.new([@login.salt,pwd].to_s).hexdigest

	is_valid = @login.valid?() & @account.valid?()
    respond_to do |format|
      if is_valid
      	@login.save
      	@account.save 
      	format.html { redirect_to(login_path, :notice => 'Account was successfully created.  Please log in to start adding recipes!') }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
      	to_show_login		# makes the encryption keys
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.xml
  def update
  	  flash[:notice] = 'Currently no editing is allowed.'
  	  redirect_to recipes_path
  end
  def original_update
  	  @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.xml
  def original_destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(accounts_url) }
      format.xml  { head :ok }
    end
  end
end
