class CategoriesController < ApplicationController
    before_action :authenticate_user

    def create
        p "*" * 50
        p "CREATING CATEGORY"
        p params[:category_name]
        p @current_user.id
        p "*" * 50
        category = Category.new(
                :name => params[:category_name], 
                :user_id => @current_user.id
            )
        p "Category"
        p category
        p "*" * 50
        if category.save
            render json: {"name": category["name"], "category_apikey": category["apikey"]}
        else
            flash[:error] = category.errors.full_messages
            redirect_to recipes_path
        end
    end


    private

end
