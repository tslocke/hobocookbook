class ApiTagCommentsController < ApplicationController

  hobo_model_controller

  auto_actions :update, :destroy
  
  auto_actions_for :api_tag_def, [:create]

end
