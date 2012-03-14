class ApiTaglibsController < ApplicationController

  hobo_model_controller

  caches_page :show

  auto_actions :show

end
