class QuestionsController < ApplicationController

  hobo_model_controller

  auto_actions :edit, :update, :destroy, :show
  
  auto_actions_for :user, [:index, :new, :create]
  
  auto_actions_for :recipes, :index
  
  def index; end
  
  index_action :answered, :scope => :with_answers
  index_action :open,     :scope => :without_answers

end
