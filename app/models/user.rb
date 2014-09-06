class User < ActiveRecord::Base
  has_and_belongs_to_many :roles, :join_table => :users_roles
  # Instead of using :authentication_keys here, we could put it in the
  # Devise initializer unde config.authentication_keys = [:username] 
  devise :ldap_authenticatable, :rememberable, :trackable, :authentication_keys => [:username]
    
    # Use the following to extract additional attributes
    #before_save :get_ldap_email
  
    #def get_ldap_email
    #  self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,"mail")
    #end
  
    # Replace with a validation of my own
    validates :username, :presence => true

    def self.find_for_authentication(conditions)
      conditions = ["username = ?", conditions[authentication_keys.first]]
      # raise StandardError, conditions.inspect
      super
    end
    def create  
      @user_session = UserSession.new(params[:user_session])  
      if @user_session.save  
        flash[:notice] = "Login successful!"  
        redirect_to user_path  
      else  
        respond_to do |wants|  
          wants.html { render :new }  
          wants.js # create.js.erb  
        end  
      end  
    end
    def destroy  
      reset_session  
      flash[:notice] = "Logout successful!"  
      redirect_to user_path   
    end
end
