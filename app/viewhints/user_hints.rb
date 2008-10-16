class UserHints < Hobo::ViewHints

  children :recipes, :questions, :answers
  
end
