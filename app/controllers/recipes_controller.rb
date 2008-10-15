class RecipesController < ApplicationController

  hobo_model_controller

  auto_actions :index, :show, :edit, :update, :destroy
  
  auto_actions_for :user, [:new, :create, :index]

end
