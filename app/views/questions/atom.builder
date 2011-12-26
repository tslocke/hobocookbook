atom_feed do |feed|
  feed.title("HoboCookbook - questions")
  feed.updated(@questions.first.created_at)

  @questions.each do |question|
    feed.entry(question) do |entry|
      entry.title(question.subject)
      if question.markdown?
        entry.content(question.description.to_html_from_markdown.html_safe, :type => 'html')
      else
        entry.content(question.description)
      end

      entry.author do |author|
        author.name(question.user.username)
      end
    end
  end
end
