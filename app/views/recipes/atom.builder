atom_feed do |feed|
  feed.title("HoboCookbook - recipes")
  feed.updated(@recipes.first.created_at)

  @recipes.each do |recipe|
    feed.entry(recipe) do |entry|
      entry.title(recipe.name)
      entry.content(recipe.body.to_html, :type => 'html')
      entry.updated(recipe.updated_at)

      entry.author do |author|
        author.name(recipe.user.username)
      end
    end
  end
end
