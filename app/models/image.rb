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

  def creatable_by?(user)
    user.administrator?
  end

  def updatable_by?(user, new)
    user.administrator?
  end

  def deletable_by?(user)
    user.administrator?
  end

  def viewable_by?(user, field)
    true
  end

end
