module Jekyll
  class Site
    def process
      self.reset
      self.read
      self.generate
      self.render

      # These must come after render if we want to have liquid templating to work.
      self.write_categories
      self.write_tags
      self.generate_archives

      self.cleanup
      self.write
    end
  end
end

