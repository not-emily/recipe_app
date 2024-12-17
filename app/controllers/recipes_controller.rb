class RecipesController < ApplicationController
  before_action :authenticate_user

  def index
    @recipes = Recipe.for_user(@current_user.id)
    @categories = Category.for_user(@current_user.id)
  end

  def show
  end

  def new
    @recipe = Recipe.new(:name => "")
    @categories = Category.for_user(@current_user.id)
  end

  def create
    recipe = Recipe.new(recipe_params)
    recipe.cover_image.attach(params[:cover_image])
    if recipe.save
      # Create categories
      params[:categories].each do |category_apikey|
        category = Category.find_by_apikey(category_apikey);
        if category
          category_link = RecipeCategory.new(:recipe_id => recipe.id, :category_id => category.id)
          if !category_link.save
            flash[:error] = category_link.errors.full_messages
            redirect_to new_recipe_path
            return
          end
        else
          flash[:error] = "Can't find category"
          redirect_to new_recipe_path
          return
        end
      end

      flash[:notice] = "Recipe is added"
      redirect_to recipes_path
    else
      flash[:error] = recipe.errors.full_messages
      redirect_to recipes_path
    end

  end

  def update
  end

  def destroy
  end

  private
  def recipe_params
    params.permit(:user_id, :name, :cover_image)
  end
end
