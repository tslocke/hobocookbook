class ApiPlugin < ActiveRecord::Base

  set_table_name "api_plugins_14"

  hobo_model # Don't put anything above this

  def self.find(*args)
    if args.first.is_a?(String) && args.first =~ /[a-zA-Z0-9_-]+/
      find_by_name args.first
    else
      super
    end
  end

  def to_param
    to_s
  end

  fields do
    name              :string, :index => true
    short_description :html
    description       :html
    edit_link_base    :string
    edit_link         :string
    position          :integer
    timestamps
  end

  attr_accessor :dir

  has_many :taglibs, :class_name => "ApiTaglib", :foreign_key => "plugin_id"

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
