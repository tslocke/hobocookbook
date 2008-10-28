class ImagesController < ApplicationController

  hobo_model_controller

  auto_actions :create, :destroy
  
  def create
    hobo_create { hobo_ajax_response }
  end
  
end
