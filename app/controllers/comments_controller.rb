class CommentsController < ApplicationController

  hobo_model_controller

  auto_actions :update, :destroy
  
  auto_actions_for :recipe, [:create]

  index_action :atom, :atom_with_spam
  caches_page :atom, :atom_with_spam

  def create_for_recipe
    expire_page :action => :atom
    expire_page :action => :atom_with_spam
    hobo_create_for :recipe
  end

  def update
    expire_page :action => :atom
    expire_page :action => :atom_with_spam
    hobo_update
  end

  def destroy
    expire_page :action => :atom
    expire_page :action => :atom_with_spam
    hobo_destroy
  end

  def atom
    @comments=Comment.includes(:user).includes(:recipe).where("users.state='active'").order("comments.created_at").reverse_order
  end

  def atom_with_spam
    @comments=Comment.includes(:user).includes(:recipe).order(:created_at).reverse_order
    render :atom
  end

end
