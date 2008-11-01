class ImagesController < ApplicationController

  hobo_model_controller

  auto_actions :create, :destroy
  
  def create
    # The iframe based image uploader is not recognised as an ajax request,
    # so we have to manually force the ajax response
    hobo_create { hobo_ajax_response }
  end
  
end
