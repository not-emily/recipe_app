class CategoriesController < ApplicationController
    before_action :authenticate_user

    def show
        @category = Category.find_by_apikey(params[:category_apikey]);
        @recipes = @category.recipes
    end

    def create
        p "*" * 50
        p "Params"
        p params
        p "*" * 50
        category = Category.new(
                :category_name => params[:category_name], 
                :user_id => @current_user.id,
            )
        if category.save
            render json: {"category_name": category["category_name"], "category_apikey": category["apikey"]}
        else
            flash[:error] = category.errors.full_messages
            redirect_to recipes_path
        end
    end
end
