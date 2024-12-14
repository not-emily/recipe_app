class RecipeCategory < ApplicationRecord
    belongs_to :category
    belongs_to :recipe

    validates :recipe_id, uniqueness: { scope: :category_id }

    before_validation              :set_apikey,
                                   :on => :create

    before_validation              :set_status,
                                   :on => :create
    
    private

    def set_apikey 
        model = RecipeCategory
        begin
            self.apikey = SecureRandom.urlsafe_base64
        end while model.exists?(apikey: self.apikey)
    end
    
    
    def set_status 
        self.status = "ACTIVE"
    end
end
