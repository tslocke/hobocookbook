# NOTE- Tagging is not implemnted 

class Tag < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    timestamps
  end

  has_many :taggings
  has_many :recipes, :through => :taggings
  
  named_scope :popular, :limit => "20" # To Do!


  # --- Hobo Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(attribute)
    true
  end

end
