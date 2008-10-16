class User < ActiveRecord::Base

  hobo_user_model # Don't put anything above this

  fields do
    username :string, :login => true, :name => true
    email_address :email_address
    administrator :boolean, :default => false
    timestamps
  end

  # This gives admin rights to the first sign-up.
  # Just remove it if you don't want that
  before_create { |user| user.administrator = true if count == 0 }
  
  
  # --- Signup lifecycle --- #

  lifecycle do

    initial_state :active

    create :anybody, :signup, 
           :params => [:username, :email_address, :password, :password_confirmation],
           :become => :active, :if => proc {|_, u| u.guest?}

    transition :nobody, :request_password_reset, { :active => :active }, :new_key => true do
      UserMailer.deliver_forgot_password(self, lifecycle.key)
    end

    transition :with_key, :reset_password, { :active => :active }, 
               :update => [ :password, :password_confirmation ]

  end
  
  
  has_many :recipes
  has_many :questions
  has_many :answers
  has_many :comments
  
  named_scope :recently_active, :order => "(select created_at from recipes where recipes.user_id = users.id order by created_at limit 1)",
                                :limit => 6
  

  # --- Hobo Permissions --- #

  def creatable_by?(creator)
    creator.administrator? || !administrator
  end

  def updatable_by?(updater, new)
    updater.administrator? || (updater == self && only_changed_fields?(new, :password, :password_confirmation, :email_address))
  end

  def deletable_by?(deleter)
    deleter.administrator?
  end

  def viewable_by?(viewer, field)
    true
  end

end
