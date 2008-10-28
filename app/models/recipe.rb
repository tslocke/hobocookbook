class Recipe < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    body :markdown
    timestamps
  end
  
  has_many :comments,  :dependent => :destroy
  has_many :images,    :dependent => :destroy
  has_many :answers,   :dependent => :destroy
  has_many :questions, :through => :answers, :uniq => true
  
  # has_many :taggings
  # has_many :tags, :through => :taggings

  include OwnedModel

end
