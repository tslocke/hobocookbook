class Image < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end
  
  has_attached_file :image, :styles => { :thumbnail => "100x100#" },
                            :path => ":rails_root/public/img/:id/:style_:basename.:extension",
                            :url => "/img/:id/:style_:basename.:extension"
  
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
