ActionController::Routing::Routes.draw do |map|

  map.site_search  'search', :controller => 'front', :action => 'search'
  map.homepage '', :controller => 'front', :action => 'index'
  
  map.manual 'manual',          :controller => 'manual', :action => 'index'
  map.manual 'manual/:section', :controller => 'manual', :action => 'manual_section'

  Hobo.add_routes(map)

end
