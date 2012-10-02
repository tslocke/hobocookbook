class FrontController < ApplicationController

  hobo_controller

  skip_before_filter :verify_authenticity_token, :only => [:search]

  def index; end

  def search
    if params[:query]
      site_search(params[:query])
    end
  end

end
