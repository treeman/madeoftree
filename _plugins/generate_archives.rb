# Generate date constrained archives
module Jekyll


  class Archive < CustomPage

    # Return yearly/monthly/daily archives for posts
    def self.split_archives(site)
      years = Hash.new { |h, k| h[k] = Array.new }

      months = Hash.new do |h, k|
        h[k] = Hash.new { |h, k| h[k] = Array.new }
      end

      days = Hash.new do |h, k|
        h[k] = Hash.new do |h, k|
          h[k] = Hash.new { |h, k| h[k] = Array.new }
        end
      end

      site.posts.each do |post|
        d = post.date
        years[d.year] << post
        months[d.year][d.month] << post
        days[d.year][d.month][d.day] << post
      end

      [years, months, days]
    end

    def initialize(site, base, posts, year, month = nil, day = nil)
      time = Time.local(year, month, day)

      title = "Archives for "

      if day
        dir = time.strftime('%Y/%m/%d')
        title += "#{time.strftime('%B %d, %Y')}"
      elsif month
        dir = time.strftime('%Y/%m')
        title += "#{time.strftime('%B %Y')}"
      else
        dir = time.strftime('%Y')
        title += "#{time.strftime('%Y')}"
      end

      dir = "blog/#{dir}"

      super site, base, dir, 'date_archive'

      self.data["title"] = title
      self.data["posts"] = posts.reverse
    end

  end


  class Site

    def generate_archives
      years, months, days = Archive.split_archives(self)

      days.each do |year, m|
        write_page Archive.new(self, self.source, years[year], year)

        m.each do |month, d|
          write_page Archive.new(self, self.source, months[year][month], year, month)
          d.each { |day, posts| write_page Archive.new(self, self.source, posts, year, month, day) }
        end
      end
    end

  end


end

