require_relative 'custom_page'

module Jekyll

  class Sitemap < CustomPage
    def initialize(site, base, dir, urls)
      super site, base, dir, 'sitemap'

      self.data['urls'] = urls
    end
  end

  class Site

    def generate_sitemap
      list = Dir.glob(self.source + "/_site/**/*")

      # Transform and keep files ending with index.html and remove ending + _site prefix.
      urls = []
      list.each do |f|
        next unless f =~ %r{_site(.+?)/?index\.html$}
        urls << $1
      end

      # Add in our sitemap as well!
      urls << "/sitemap"

      write_page Sitemap.new(self, self.source, 'sitemap', urls.sort)
    end
  end

end

