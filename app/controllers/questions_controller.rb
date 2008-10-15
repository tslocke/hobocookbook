class QuestionsController < ApplicationController

  hobo_model_controller

  auto_actions :index, :edit, :update, :destroy
  
  auto_actions_for :user, [:new, :create]

end
