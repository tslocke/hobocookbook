class AnswersController < ApplicationController

  hobo_model_controller

  auto_actions_for :question, :create
  
  auto_actions_for :user, :index

end
