OwnedModel = classy_module do
  
  belongs_to :user, :creator => true
  
  
  def create_permitted?
    acting_user.signed_up? && (user == acting_user || new_record?)
  end

  def update_permitted?
    acting_user.administrator? || (acting_user == user && !user_changed?)
  end

  def destroy_permitted?
    acting_user.administrator? || acting_user == user
  end

  def view_permitted?(attribute)
    true
  end
  
end
