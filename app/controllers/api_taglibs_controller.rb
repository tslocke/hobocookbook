class ApiTaglibsController < ApplicationController

  hobo_model_controller
  
  caches_page :index, :show

  auto_actions :all

end
