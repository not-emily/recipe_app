class Recipe < ApplicationRecord
    belongs_to :user
  
    before_validation              :set_apikey,
                                   :on => :create
  
    before_validation              :set_status,
                                   :on => :create
  
  
    scope :for_user, ->(user) { where('user_id = ?', user) if user.present? }
  
  
    private
  
    def set_apikey
      model = self.class.name.capitalize.constantize
      begin
        self.apikey = SecureRandom.urlsafe_base64
      end while model.exists?(apikey: self.apikey)
    end
  
  
    def set_status
      self.status = "ACTIVE"
    end
  
end
