class RecipesController < ApplicationController

  hobo_model_controller

  auto_actions :index, :show, :edit, :update, :destroy

  auto_actions_for :user, [:new, :create, :index]

  autocomplete

  index_action :atom, :atom_with_spam
  caches_page :atom, :atom_with_spam


  def create_for_user
    expire_page :action => :atom
    expire_page :action => :atom_with_spam
    hobo_create do
      redirect_to this, :edit if valid? && params[:stay_here]
    end
  end

  def update
    expire_page :action => :atom
    expire_page :action => :atom_with_spam
    hobo_update do
      redirect_to this, :edit if valid? && params[:stay_here]
    end
  end

  def destroy
    expire_page :action => :atom
    expire_page :action => :atom_with_spam
    hobo_destroy
  end

  def atom
    @recipes=Recipe.includes(:user).where("users.state='active'").order("recipes.created_at").reverse_order
  end

  def atom_with_spam
    @recipes=Recipe.includes(:user).order(:created_at).reverse_order
    render :atom
  end
end
