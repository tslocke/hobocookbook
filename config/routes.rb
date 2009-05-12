ActionController::Routing::Routes.draw do |map|

  map.site_search  'search', :controller => 'front', :action => 'search'
  map.homepage '', :controller => 'front', :action => 'index'
  
  map.manual         'manual',          :controller => 'manual', :action => 'index'
  map.manual_section 'manual/:section', :controller => 'manual', :action => 'manual_section'
  map.manual_section 'manual/:section/:subsection', :controller => 'manual', :action => 'manual_subsection'

  map.tutorials 'tutorials',           :controller => 'tutorials', :action => 'index'
  map.tutorial  'tutorials/:tutorial', :controller => 'tutorials', :action => 'show'

  Hobo.add_routes(map)

end
