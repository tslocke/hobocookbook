ActionController::Routing::Routes.draw do |map|

  map.site_search  'search', :controller => 'front', :action => 'search'
  map.homepage '', :controller => 'front', :action => 'index'

  Hobo.add_routes(map)

end
