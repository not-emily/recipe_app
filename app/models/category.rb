class Category < ApplicationRecord
    belongs_to :user
    has_many :recipe_categories, :dependent => :destroy
    has_many :recipes, through: :recipe_categories

    has_one_attached :cover_image

    validates_presence_of           :user_id
    validates_presence_of           :name

    before_validation               :set_apikey,
                                    :on => :create

    before_validation               :set_status,
                                    :on => :create

    scope :for_user, ->(user) { where('user_id = ?', user) if user.present? }

    private

    def set_apikey 
        model = Category
        begin
            self.apikey = SecureRandom.urlsafe_base64
        end while model.exists?(apikey: self.apikey)
    end

    def set_status 
        self.status = "ACTIVE"
    end
end
