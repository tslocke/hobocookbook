class ApiTagComment < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    body     :optional_markdown
    markdown :boolean
    timestamps
  end

  belongs_to :api_tag_def

  include OwnedModel

end
