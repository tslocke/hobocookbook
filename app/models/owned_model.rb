OwnedModel = classy_module do
  
  belongs_to :user, :creator => true
  
  
  def create_permitted?
    acting_user.signed_up? && user == acting_user
  end

  def update_permitted?
    acting_user.administrator? || (acting_user == user && !user_changed?)
  end

  def destroy_permitted?
    acting_user.administrator? || acting_user == user
  end

  def view_permitted?(attribute)
    acting_user == user || acting_user.administrator? || user.state=="active"
  end
  
end
