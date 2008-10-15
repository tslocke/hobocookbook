class CommentsController < ApplicationController

  hobo_model_controller

  auto_actions :update, :destroy
  
  auto_actions_for :recipe, [:create]
  
end
