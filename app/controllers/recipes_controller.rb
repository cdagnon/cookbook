class RecipesController < ApplicationController
	before_filter :setup_user_if_logged_in
	before_filter :verify_logged_in_or_redirect, :only => [:new, :create, :edit, :update]

  # GET /recipes
  # GET /recipes.xml
  def index
  	if( ! is_blank?(params[:name]) ) then
    	@search_by = params[:name]
	    @recipes = Recipe.find :all, :conditions => ['name LIKE ?', "%#{@search_by}%"]
	elsif( ! is_blank?(params[:ingredient_name]) ) then
    	@search_by_ingredient = params[:ingredient_name]
	    @recipes = Recipe.find :all, :select => "DISTINCT (recipe.*)", :include => [:recipe_ingredients], :joins => :ingredients, :conditions => ["ingredients.name LIKE ?", "%#{@search_by_ingredient}%"]
    else
	    @recipes = Recipe.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recipes }
    end
  end

  # GET /recipes/1
  # GET /recipes/1.xml
  def show
  	  @recipe = Recipe.find(params[:id], :include => :recipe_ingredients)
#  	  @current_batch_size = $1 if( (! is_blank?(params[:batch_size])) && params[:batch_size] =~ /\A([1-9][0-9]?(\/[1-9][0-9]?)?)\Z/ )
	@current_batch_size = "#{$1}#{$4 ? "/#{$4}" : ''}" if( (! is_blank?(params[:batch_size])) && params[:batch_size] =~ /\A([1-9][0-9]?)((\/|%2F)([1-9][0-9]?))?\Z/ )
#Rails.logger.warn("PARAM=[#{params[:batch_size]}]  @current=[#{@current_batch_size}]")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recipe }
    end
  end

  # GET /recipes/new
  # GET /recipes/new.xml
  def new
    @recipe = Recipe.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @recipe }
    end
  end

  # GET /recipes/1/edit
  def edit
  	  flash[:notice] = 'Currently no editing is allowed.'
  	  redirect_to recipes_path
  end
  def original_edit
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes
  # POST /recipes.xml
  def create
    @recipe = Recipe.new(params[:recipe])
    errors = process_ingredient_inputs(params, @recipe)
    if(errors) then
		# reshow
		return
	end
	@recipe.entered_by_id = @current_user.id

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to(@recipe, :notice => 'Recipe was successfully created.') }
        format.xml  { render :xml => @recipe, :status => :created, :location => @recipe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.xml
  def update
  	  flash[:notice] = 'Currently no updates are allowed.'
  	  redirect_to recipes_path
  end
  def original_update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html { redirect_to(@recipe, :notice => 'Recipe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.xml
  def original_destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to(recipes_url) }
      format.xml  { head :ok }
    end
  end
  
  def add_ith_ingredient
  	  @row_index = params[:ith].to_i + 1
  	  respond_to do |format|
  	  	  format.js { }
  	  end
  end
  
  
  private
  def process_ingredient_inputs( params, recipe )
    qs = params.keys.find_all{ |key| key =~ /\Aquantity_[1-9][0-9]?\Z/ }
#    RAILS_DEFAULT_LOGGER.warn("Qs=#{qs.inspect}")
	failures = []
	qs.each{ |quantity_key|
		index = quantity_key.gsub('quantity_','').to_i
		txt_qty = params[quantity_key]
		txt_msr = params["measurement_#{index}"]
		txt_ing = params["ingredient_name_#{index}"]
		failures << [index, 'missing ingredient information - programming error?'] and next if is_blank?(txt_qty) || is_blank?(txt_msr) || is_blank?(txt_ing)
		ing = Ingredient.find_by_name(txt_ing)
		if(ing.nil?) then
			ing = Ingredient.create( :name => txt_ing, :description => txt_ing, :created_by_account_id => @current_user.id )
		end
		if( ing.nil? || ! recipe.recipe_ingredients.build( :ingredient => ing, :quantity_count => txt_qty, :quantity_type => txt_msr )) then
			failures << [index, 'bad inputs']
		end
	}
	return failures if ! failures.empty?
  end
end
