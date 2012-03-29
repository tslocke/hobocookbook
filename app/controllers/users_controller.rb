class UsersController < ApplicationController

  hobo_user_controller

  auto_actions :all, :except => [ :new, :create ]

  def do_signup
    unless verify_recaptcha
      self.this = User::Lifecycle.creators[:signup].candidate(current_user, params[:user])
      verify_recaptcha this
      render :action => :signup
      return
    end
    hobo_do_signup
  end

end
