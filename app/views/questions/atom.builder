atom_feed do |feed|
  feed.title("HoboCookbook - questions")
  feed.updated(@questions.first.created_at)

  @questions.each do |question|
    feed.entry(question) do |entry|
      entry.title(question.name)
      entry.content(question.body, :type => 'html')

      entry.author do |author|
        author.name(question.user.username)
      end
    end
  end
end
