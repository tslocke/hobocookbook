# NOTE- Tagging is not implemnted 

class Tagging < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end

  belongs_to :tag
  belongs_to :recipe

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
