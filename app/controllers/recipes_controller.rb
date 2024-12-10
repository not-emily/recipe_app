class RecipesController < ApplicationController
  before_action :authenticate_user

  def index
    @recipes = Recipe.for_user(@current_user)
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    recipe = Recipe.new(recipe_params)
    recipe.cover_image.attach(params[:cover_image])
    if recipe.save
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
