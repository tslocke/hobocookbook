class QuestionsController < ApplicationController

  hobo_model_controller

  auto_actions :edit, :update, :destroy, :show

  auto_actions_for :user, [:index, :new, :create]

  auto_actions_for :recipes, :index

  index_action :atom, :atom_with_spam
  caches_page :atom, :atom_with_spam

  def index; end

  index_action :answered, :scope => :with_answers
  index_action :open,     :scope => :without_answers

  def create_for_user
    expire_page :action => :atom
    expire_page :action => :atom_with_spam
    hobo_create_for :user
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
    @questions=Question.includes(:user).where("users.state='active'").order("questions.created_at").reverse_order
  end

  def atom_with_spam
    @questions=Question.includes(:user).order(:created_at).reverse_order
    render :atom
  end
end
