class ApiTagComment < ActiveRecord::Base

  # so we can coexist with other
  # versions of the cookbook
  set_table_name "api_tag_comments_14"

  hobo_model # Don't put anything above this

  fields do
    body     :optional_markdown
    markdown :boolean
    timestamps
  end

  belongs_to :api_tag_def

  include OwnedModel

end
