class Answer < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    body :text
    timestamps
  end
  
  belongs_to :recipe
  belongs_to :question

  include OwnedModel

end
