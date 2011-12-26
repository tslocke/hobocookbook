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
  before_create { |user| user.administrator = true if user.class.count == 0 }

  children :recipes, :questions, :answers

  named_scope :administrator, :conditions => {:administrator => true}

  # --- Signup lifecycle --- #

  lifecycle do

    state :active
    state :pending, :default => true

    create :signup, :available_to => "Guest",
           :params => [:username, :email_address, :password, :password_confirmation],
           :become => :pending

    transition :request_password_reset, { :active => :active }, :new_key => true do
      UserMailer.deliver_forgot_password(self, lifecycle.key)
    end

    transition :reset_password, { :active => :active }, :available_to => :key_holder,
               :params => [ :password, :password_confirmation ]

    transition :approve, { :pending => :active }, :available_to => "User.administrator" do
      # FIXME: use sweepers
      ActionController::Base.expire_page("/recipes/atom.xml")
    end

    transition :request_password_reset, { :pending => :pending }, :new_key => true do
      UserMailer.deliver_forgot_password(self, lifecycle.key)
    end

    transition :reset_password, { :pending => :pending }, :available_to => :key_holder,
               :params => [ :password, :password_confirmation ]

  end


  has_many :recipes, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  #named_scope :recently_active, :order => "(select created_at from recipes where recipes.user_id = users.id order by created_at limit 1)",
  #                              :limit => 6
  scope :recently_active,  order("(select created_at from recipes where recipes.user_id = users.id order by created_at limit 1)").limit(6)

  # --- Hobo Permissions --- #

  def create_permitted?
    false
  end

  def update_permitted?
    acting_user.administrator? || (acting_user == self && only_changed?(:crypted_password, :email_address))
    # Note: crypted_password has attr_protected so although it is permitted to change, it cannot be changed
    # directly from a form submission.
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end

