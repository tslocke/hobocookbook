OwnedModel = classy_module do
  
  belongs_to :user, :creator => true
  
  
  def creatable_by?(creator)
    creator.signed_up? && user == creator
  end

  def updatable_by?(updater, updated)
    updater.administrator? || (updater == user && same_fields?(updated, :user))
  end

  def deletable_by?(deleter)
    deleter.administrator? || deleter == user
  end

  def viewable_by?(user, field)
    true
  end
  
end