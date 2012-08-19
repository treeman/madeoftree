module Jekyll

    class Category < CustomPage
        def initialize(site, base, dir, category)
            super site, base, dir, 'category'

            self.data['category'] = category
            self.data['title'] = "#{site.config['category_title_prefix'] || 'Category: '}#{category}"
        end
    end

    class Categories < CustomPage
        def initialize(site, base, dir)
            super site, base, dir, 'categories'

            self.data['categories'] = site.categories.keys.sort
        end
    end

    class Tag < CustomPage
        def initialize(site, base, dir, tag)
            super site, base, dir, 'tag'

            self.data['tag'] = tag
            self.data['title'] = "#{site.config['tag_title_prefix'] || 'Tag: '}#{tag}"
        end
    end

    class Tags < CustomPage
        def initialize(site, base, dir)
            super site, base, dir, 'tags'

            self.data['tags'] = site.tags.keys.sort
        end
    end

    class Site

        def write_categories
            throw "No 'category' layout found." unless self.layouts.key? 'category'

            dir = self.config['category_dir'] || 'categories'
            write_page Categories.new(self, self.source, dir) if self.layouts.key? 'categories'

            self.categories.keys.each do |category|
                write_page Category.new(self, self.source, File.join(dir, category.slugize), category)
            end
        end

        def write_tags
            throw "No 'category' layout found." unless self.layouts.key? 'tag'

            dir = self.config['tag_dir'] || 'tags'
            write_page Tags.new(self, self.source, dir) if self.layouts.key? 'tags'

            self.tags.keys.each do |tag|
                write_page Tag.new(self, self.source, File.join(dir, tag.slugize), tag)
            end
        end
    end

end

