class Recipe < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    body :markdown
    timestamps
  end
  
  belongs_to :user, :creator => true
  
  has_many :comments, :dependent => :destroy
  has_many :images
  has_many :answers
  has_many :questions, :through => :answers
  
  has_many :taggings
  has_many :tags, :through => :taggings


  # --- Hobo Permissions --- #

  def creatable_by?(creator)
    user.signed_up? && creator == user
  end

  def updatable_by?(updator, updated)
    updator == user && same_fields?(updated, :user)
  end

  def deletable_by?(deleter)
    user.administrator?
  end

  def viewable_by?(viewer, field)
    true
  end

end
