class AnswerHints < Hobo::ViewHints

  field_names :body => "", :recipe => "See recipe"
  
  field_help  :recipe => "Enter keywords from the name of a recipe"

  children :answers

end
