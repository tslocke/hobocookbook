class HoboFields::Types::MarkdownString < HoboFields::Types::RawMarkdownString

  def to_html(xmldoctype = true)
    return "" if blank?
    # the underscore fix, stolen from GitHub Flavored Markdown
    # which was buggy as all hell, so I had to fix it.   grrr.
    s=self.gsub(/^(?! {4}|\t).*$/) do |line|
      line.gsub(/\w+_\w+_\w[\w_]*/) do |x|
        x.gsub('_', '\_') if x.split('').sort.to_s[0..1] == '__'
      end
    end
    begin
      s=Maruku.new(s).to_html
    rescue
      "Uh oh - looks like there was a problem rendering that markdown."
    end
    HoboFields::SanitizeHtml.sanitize(s)
  end

end

class OptionalMarkdown < HoboFields::Types::Text

  HoboFields.register_type(:optional_markdown, self)

  def to_html_from_markdown
    HoboFields::Types::MarkdownString.new(self).to_html
  end

end

