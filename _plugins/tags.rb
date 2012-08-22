module Jekyll

  # Unordered list of featured posts
  class FeaturedPosts < Liquid::Tag
    def render(context)
      site = context.registers[:site]
      featured = site.config['featured_posts']

      result = "<ul>"

      # site.posts returns a string of post content for some reason...?
      posts = site.posts.map { |p| p.to_liquid }

      posts.select { |p| featured.include?(p['title']) }.each do |post|
        result = result + "\n<li><a href=\"#{post['url']}\">#{post['title']}</a></li>"
      end

      result = result + "\n</ul>"
    end
  end

  # Create an unordered list of featured projects
  class FeaturedProjects < Liquid::Tag
    def render(context)
      site = context.registers[:site]
      featured = site.config['featured_projects']
      result = "<ul>"

      site.projects.select { |p| featured.include?(p['title']) }.each do |project|
        result = result + "\n<li><a href=\"#{project['link']}\">#{project['title']}</a></li>"
      end

      result = result + "\n</ul>"
    end
  end

  # Create an unordered list of projects
  class ProjectList < Liquid::Tag
    def render(context)
      site = context.registers[:site]
      result = "<ul>"

      site.projects.each do |project|
        result = result + "\n<li><a href=\"#{project['link']}\">#{project['title']}</a></li>"
      end

      result = result + "\n</ul>"
    end
  end

  # Create an unordered list of featured games
  class FeaturedGames < Liquid::Tag
    def render(context)
      site = context.registers[:site]
      featured = site.config['featured_games']
      result = "<ul>"

      site.games.select { |p| featured.include?(p['title']) }.each do |game|
        result = result + "\n<li><a href=\"#{game['link']}\">#{game['title']}</a></li>"
      end

      result = result + "\n</ul>"
    end
  end

  # Create an unordered list of games
  class GamesList < Liquid::Tag
    def render(context)
      site = context.registers[:site]
      result = "<ul>"

      site.games.select.each do |game|
        result = result + "\n<li><a href=\"#{game['link']}\">#{game['title']}</a></li>"
      end

      result = result + "\n</ul>"
    end
  end

end

Liquid::Template.register_tag('featured_posts', Jekyll::FeaturedPosts)
Liquid::Template.register_tag('featured_projects', Jekyll::FeaturedProjects)
Liquid::Template.register_tag('featured_games', Jekyll::FeaturedGames)
Liquid::Template.register_tag('project_list', Jekyll::ProjectList)
Liquid::Template.register_tag('games_list', Jekyll::GamesList)

