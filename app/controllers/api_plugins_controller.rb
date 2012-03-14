class ApiPluginsController < ApplicationController

  hobo_model_controller

  caches_page :index, :show

  auto_actions :index, :show

  def index
    hobo_index(:order => "position")
  end

end
