class ApiTaglib < ActiveRecord::Base

  hobo_model # Don't put anything above this
  
  def self.find(*args)
    if args.first =~ /[a-zA-Z0-9_-]+/
      find_by_name args.first
    else
      super
    end
  end
  
  def to_param
    to_s
  end

  fields do
    name        :string
    description :html
    timestamps
  end

  has_many :tags, :class_name => "ApiTagDef", :foreign_key => "taglib_id"
  
  set_default_order "name"
    

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
