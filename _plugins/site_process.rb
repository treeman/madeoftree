module Jekyll
  class Site
    def process
      self.reset
      self.read
      self.generate
      self.render

      # These must come after render if we want to have liquid templating to work.
      self.generate_categories
      self.generate_tags
      self.generate_archives

      self.generate_sitemap

      self.generate_notfound

      self.cleanup
      self.write
    end
  end
end

