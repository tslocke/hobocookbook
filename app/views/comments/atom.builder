atom_feed do |feed|
  feed.title("HoboCookbook - comments")
  feed.updated(@comments.first._?.created_at)

  @comments.each do |comment|
    feed.entry(comment, :url => recipe_path(comment.recipe)) do |entry|
      entry.title("Comment on #{comment.recipe.name}#{' (pending moderation)' if comment.user.state=='pending'}")
      if comment.markdown?
        entry.content(comment.body.to_html_from_markdown.html_safe, :type => 'html')
      else
        entry.content(comment.body)
      end

      entry.author do |author|
        author.name(comment.user.username)
      end
    end
  end
end
