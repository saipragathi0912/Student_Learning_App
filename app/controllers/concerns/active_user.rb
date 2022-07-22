module ActiveUser

    def validate_user!
      user = User.find_by(id: doorkeeper_token.resource_owner_id) unless doorkeeper_token.blank?
      throw_error("Unauthorized user.", 401) if user.blank?
      #throw_error("Session expired.", 401) if ((Time.now - doorkeeper_token.created_at) / 86400) > Rails.application.secrets.user_active_session_duration
    end
  
    def current_user
      User.find_by(id: doorkeeper_token.resource_owner_id) unless doorkeeper_token.blank?
    end
  
    def generate_refresh_token
      loop do
        token = SecureRandom.hex(32)
        break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
      end
    end 
end