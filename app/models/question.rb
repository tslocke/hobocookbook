require 'optional_markdown'

class Question < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    description :optional_markdown
    markdown    :boolean
    timestamps
  end
  
  belongs_to :user, :creator => true
  
  has_many :answers
  has_many :recipes, :through => :answers


  # --- Hobo Permissions --- #

  def creatable_by?(creator)
    user.signed_up? && creator == user
  end

  def updatable_by?(updator, updated)
    updator == user && same_fields?(updated, :user)
  end

  def deletable_by?(user)
    user.administrator?
  end

  def viewable_by?(user, field)
    true
  end

end
