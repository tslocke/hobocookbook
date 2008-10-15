module HoboFields

  class OptionalMarkdown < HoboFields::Text

    HoboFields.register_type(:optional_markdown, self)

  end

end
