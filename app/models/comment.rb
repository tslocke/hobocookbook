require 'optional_markdown'

class Comment < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    body     :optional_markdown
    markdown :boolean
    timestamps
  end
  
  belongs_to :user, :creator => true
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
