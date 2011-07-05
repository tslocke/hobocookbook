# This is an auto-generated file: don't edit!
# You can add your own routes in the config/routes.rb file
# which will override the routes in this file.

Hobocookbook::Application.routes.draw do


  # Resource routes for controller "images"
  post 'images(.:format)' => 'images#create', :as => 'create_image'
  delete 'images/:id(.:format)' => 'images#destroy', :as => 'destroy_image', :constraints => { :id => %r([^/.?]+) }


  # Index action routes for controller "questions"
  get 'questions/answered(.:format)', :as => 'answered_questions'
  get 'questions/open(.:format)', :as => 'open_questions'

  # Resource routes for controller "questions"
  get 'questions(.:format)' => 'questions#index', :as => 'questions'
  get 'questions/:id/edit(.:format)' => 'questions#edit', :as => 'edit_question'
  get 'questions/:id(.:format)' => 'questions#show', :as => 'question', :constraints => { :id => %r([^/.?]+) }
  put 'questions/:id(.:format)' => 'questions#update', :as => 'update_question', :constraints => { :id => %r([^/.?]+) }
  delete 'questions/:id(.:format)' => 'questions#destroy', :as => 'destroy_question', :constraints => { :id => %r([^/.?]+) }

  # Owner routes for controller "questions"
  get 'recipes/:recipe_id/questions(.:format)' => 'questions#index_for_recipe', :as => 'questions_for_recipe'
  get 'users/:user_id/questions(.:format)' => 'questions#index_for_user', :as => 'questions_for_user'
  get 'users/:user_id/questions/new(.:format)' => 'questions#new_for_user', :as => 'new_question_for_user'
  post 'users/:user_id/questions(.:format)' => 'questions#create_for_user', :as => 'create_question_for_user'


  # Resource routes for controller "api_tag_defs"
  get 'api_tag_defs(.:format)' => 'api_tag_defs#index', :as => 'api_tag_defs'
  get 'api_tag_defs/:id(.:format)' => 'api_tag_defs#show', :as => 'api_tag_def', :constraints => { :id => %r([^/.?]+) }


  # Resource routes for controller "api_taglibs"
  get 'api_taglibs(.:format)' => 'api_taglibs#index', :as => 'api_taglibs'
  get 'api_taglibs/:id(.:format)' => 'api_taglibs#show', :as => 'api_taglib', :constraints => { :id => %r([^/.?]+) }


  # Index action routes for controller "recipes"
  get 'recipes/complete_name(.:format)', :as => 'complete_name_recipes'

  # Resource routes for controller "recipes"
  get 'recipes(.:format)' => 'recipes#index', :as => 'recipes'
  get 'recipes/:id/edit(.:format)' => 'recipes#edit', :as => 'edit_recipe'
  get 'recipes/:id(.:format)' => 'recipes#show', :as => 'recipe', :constraints => { :id => %r([^/.?]+) }
  put 'recipes/:id(.:format)' => 'recipes#update', :as => 'update_recipe', :constraints => { :id => %r([^/.?]+) }
  delete 'recipes/:id(.:format)' => 'recipes#destroy', :as => 'destroy_recipe', :constraints => { :id => %r([^/.?]+) }

  # Owner routes for controller "recipes"
  get 'users/:user_id/recipes/new(.:format)' => 'recipes#new_for_user', :as => 'new_recipe_for_user'
  post 'users/:user_id/recipes(.:format)' => 'recipes#create_for_user', :as => 'create_recipe_for_user'
  get 'users/:user_id/recipes(.:format)' => 'recipes#index_for_user', :as => 'recipes_for_user'


  # Lifecycle routes for controller "users"
  post 'users/signup(.:format)' => 'users#do_signup', :as => 'do_user_signup'
  get 'users/signup(.:format)' => 'users#signup', :as => 'user_signup'
  put 'users/:id/reset_password(.:format)' => 'users#do_reset_password', :as => 'do_user_reset_password'
  get 'users/:id/reset_password(.:format)' => 'users#reset_password', :as => 'user_reset_password'

  # Resource routes for controller "users"
  get 'users(.:format)' => 'users#index', :as => 'users'
  get 'users/:id/edit(.:format)' => 'users#edit', :as => 'edit_user'
  get 'users/:id(.:format)' => 'users#show', :as => 'user', :constraints => { :id => %r([^/.?]+) }
  put 'users/:id(.:format)' => 'users#update', :as => 'update_user', :constraints => { :id => %r([^/.?]+) }
  delete 'users/:id(.:format)' => 'users#destroy', :as => 'destroy_user', :constraints => { :id => %r([^/.?]+) }

  # Show action routes for controller "users"
  get 'users/:id/account(.:format)' => 'users#account', :as => 'user_account'

  # User routes for controller "users"
  match 'login(.:format)' => 'users#login', :as => 'user_login'
  get 'logout(.:format)' => 'users#logout', :as => 'user_logout'
  match 'forgot_password(.:format)' => 'users#forgot_password', :as => 'user_forgot_password'


  # Resource routes for controller "api_tag_comments"
  put 'api_tag_comments/:id(.:format)' => 'api_tag_comments#update', :as => 'update_api_tag_comment', :constraints => { :id => %r([^/.?]+) }
  delete 'api_tag_comments/:id(.:format)' => 'api_tag_comments#destroy', :as => 'destroy_api_tag_comment', :constraints => { :id => %r([^/.?]+) }

  # Owner routes for controller "api_tag_comments"
  post 'api_tag_defs/:api_tag_def_id/comments(.:format)' => 'api_tag_comments#create_for_api_tag_def', :as => 'create_api_tag_comment_for_api_tag_def'


  # Owner routes for controller "answers"
  get 'users/:user_id/answers(.:format)' => 'answers#index_for_user', :as => 'answers_for_user'
  post 'questions/:question_id/answers(.:format)' => 'answers#create_for_question', :as => 'create_answer_for_question'


  # Resource routes for controller "comments"
  put 'comments/:id(.:format)' => 'comments#update', :as => 'update_comment', :constraints => { :id => %r([^/.?]+) }
  delete 'comments/:id(.:format)' => 'comments#destroy', :as => 'destroy_comment', :constraints => { :id => %r([^/.?]+) }

  # Owner routes for controller "comments"
  post 'recipes/:recipe_id/comments(.:format)' => 'comments#create_for_recipe', :as => 'create_comment_for_recipe'

end
