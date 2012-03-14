class ApiTagDefsController < ApplicationController

  hobo_model_controller

  auto_actions :show, :index

  auto_actions_for :taglib, [:index]

  caches_page :show, :tagdef

  def show
    conditions = {:tag => params[:id]}
    conditions[:for_type] = params[:for]
    conditions[:taglib_id] = ApiTaglib.find_by_name(params[:taglib]).id if params[:taglib]
    self.this = ApiTagDef.find(:first, :conditions => conditions)
    hobo_show
  end

  def tagdef
    self.this = ApiPlugin.find_by_name(params[:plugin]).taglibs.find_by_name(params[:taglib]).tags.find_by_tag_and_for_type(params[:tag], params[:for])
    hobo_show
  end
end
