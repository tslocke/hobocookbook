class RecipesController < ApplicationController

  hobo_model_controller

  auto_actions :index, :show, :edit, :update, :destroy
  
  auto_actions_for :user, [:new, :create, :index]
  
  autocomplete
  
  def create_for_user
    hobo_create do
      redirect_to this, :edit if valid? && params[:stay_here]
    end
  end

  def update
    hobo_update do
      redirect_to this, :edit if valid? && params[:stay_here]
    end
  end

end
