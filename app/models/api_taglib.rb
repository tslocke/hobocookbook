class ApiTaglib < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name        :string
    description :html
    timestamps
  end

  has_many :tags, :class_name => "ApiTagDef", :foreign_key => "taglib_id", :dependent => :destroy
  
  
  def self.find(*args)
    if args.first =~ /[a-zA-Z0-9_-]+/
      find_by_name(args.first)
    else
      super
    end
  end
  
  def to_param
    name
  end

  # --- Hobo Permissions --- #

  def creatable_by?(creator)
    creator.administrator?
  end

  def updatable_by?(updater, updated)
    updater.administrator?
  end

  def deletable_by?(deleter)
    deleter.administrator?
  end

  def viewable_by?(viewer, field)
    true
  end

end
