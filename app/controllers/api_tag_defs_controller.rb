class ApiTagDefsController < ApplicationController

  hobo_model_controller

  auto_actions :show, :index

  def show
    conditions = {:tag => params[:id]}
    conditions[:for_type] = params[:for]
    conditions[:taglib_id] = ApiTaglib.find_by_name(params[:taglib]).id if params[:taglib]    
    self.this = ApiTagDef.find(:first, :conditions => conditions)
    hobo_show
  end
  
end
