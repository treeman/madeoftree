require_relative 'custom_page'

module Jekyll

  class Game < Page
    def initialize(site, base, dir, game)
      super site, base, dir, game['base_file']

      # Assimilate game data for access in template e.g. {{ page.link }} etc
      game.each do |k, v|
        self.data[k] = v
      end

    end
  end

  class Games < CustomPage
    def initialize(site, base, dir)
      super site, base, dir, 'games'
    end
  end

  class Site

    GAMES_FOLDER = 'games'

    # Write all games
    def generate_games
        get_games
    end

   private

    def get_game_file_info(file)
      if m = %r{
                (?<base>.+/download/)
                (?<filename>
                  (?<platform>[^-_]+)
                  (?<arch>
                     [^-]+
                  )?
                  -
                  (?<name>.+)
                  \.(?<ext>[^.]+)
                )
                $
               }x.match(file)
        info = {}

        info['filename'] = m[:filename]
        info['link'] = '/' + m[:base] + info['filename']
        info['platform'] = m[:platform]
        info['arch'] = m[:arch] || ''
        info['name'] = m[:name].gsub('_', ' ')
        info['ext'] = m[:ext]

        descr = info['platform']
        descr += ' ' + info['arch'] if info['arch']
        descr += ' ' + info['name']
        info['descr'] = descr

        info
      end
    end

    def get_game_screen_info(file)
      if m = %r{
                (?<link>
                  .*/screenshot/
                  (?<descr>.+)
                  \.[^.]+
                )
                $
               }x.match(file)
        info = {}

        info['link'] = '/' + m[:link]
        info['descr'] = m[:descr]

        info
      end
    end

    # Return array of games
    def get_games
      games = {}

      files = Dir.glob(GAMES_FOLDER + "/**/*")

      files.each do |f|
        if m = %r{
                  #{GAMES_FOLDER}
                  /
                  (?<name>[^/]+)
                  /
                  (?<rest>.*)
                }x.match(f)

          games[m[:name]] = {} unless games.has_key? (m[:name])

          game = games[m[:name]]
          game['dir'] = GAMES_FOLDER + '/' + m[:name]
          #puts "dir: " + game['dir']
          game['link'] = '/' + game['dir']

          if m[:rest] =~ /^index\.[^.]+$/
            game['base_file'] = m[:rest]

            game['index_file'] = f
          elsif m[:rest] =~ %r{^screenshot/([^/]+)$}
            info = get_game_screen_info(f)

            game['screenshots'] = [] unless game.has_key?('screenshots')
            game['screenshots'] << info
          elsif m[:rest] =~ %r{^download/([^/]+)$}
            info = get_game_file_info(f)

            game['downloads'] = [] unless game.has_key?('downloads')
            game['downloads'] << info
          end

        end
      end

      # Write game files
      games.each do |name, game|
        write_page Game.new(self, self.source, game['dir'], game)
      end
    end

  end

  class GenerateGames < Generator
    priority :high

    def generate(site)
      site.generate_games
    end
  end

end

