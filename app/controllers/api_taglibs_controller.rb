class ApiTaglibsController < ApplicationController

  hobo_model_controller
  
  caches_page :index, :show

  auto_actions :index, :show

  def index
    library = params[:library] || "rapid"
    hobo_index(:conditions => {:library => library}, :order => "name")
  end

end
