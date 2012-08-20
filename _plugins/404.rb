module Jekyll

  class NotFound < Page
    def initialize(site, base)
      @site = site
      @base = base
      @dir = '/'
      @name = '404.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'notfound.html')

      self.data['projects'] = site.projects
    end
  end

  class Site
    def write_notfound
      write_page NotFound.new(self, self.source)
    end
  end

end

