module Jekyll
  class Site
    def process
      self.reset
      self.read

      # Hack for us to be able to render project list in footer...
      self.collect_project_data

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

      puts "Build complete"
    end
  end
end

