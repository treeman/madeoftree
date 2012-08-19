module Jekyll
  class Site
    def process
      self.reset
      self.read
      self.generate
      self.render

      # These must come after render if we want to have liquid templating work
      # for tag and categories posts.
      self.write_categories
      self.write_tags

      self.cleanup
      self.write
    end
  end
end

