require_relative 'custom_page'

module Jekyll

  class Game < Page
    def initialize(site, base, dir, game)
      super site, base, dir, game['base_file']

      # Find a showcased screenshot
      if self.data['showcase']
        game['screenshots'].each do |s|
          if s['filename'] == self.data['showcase']
            game['screen'] = s['link']
          end
        end
      end

      # Default to first screen
      unless game['screen']
        game['screen'] = game['screenshots'][0]['link']
      end

      # Collect data from yaml front matter
      self.data.each do |k, v|
        game[k] = v
      end

      # Assimilate game data for access in template e.g. {{ page.link }} etc
      self.data = game
    end
  end

  class Games < CustomPage
    def initialize(site, base, dir, games)
      super site, base, dir, 'games'

      self.data['games'] = games
    end
  end

  class Site

    GAMES_FOLDER = 'games'

    @@games = []

    def games
      @@games
    end

    # Write all games
    def generate_games
      games = get_games

      # Write game files and collect game info to self.games at the same time
      games.each do |game|
        write_page Game.new(self, self.source, game['dir'], game)
      end

      # Sort games by date tag, which lives inside yaml front matter
      games = games.sort_by { |g| g['date'] }.reverse!

      # Save game info in site for use in tags etc
      @@games = games

      # Write game main page
      write_page Games.new(self, self.source, GAMES_FOLDER, games)
    end

   private

    def get_game_file_info(file)
      if m = %r{
                (?<base>.+/download/)
                (?<filename>
                  (?<platform>[^-_]+)
                  (_
                    (?<arch>[^-]+)
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
        info['descr'] = descr

        full_descr = info['platform']
        full_descr += ' ' + info['arch'] if info['arch']
        full_descr += ' ' + info['name']
        info['full_descr'] = full_descr

        info
      end
    end

    def get_game_screen_info(file)
      if m = %r{
                (?<link>
                  .*/screenshot/
                  (?<filename>
                    (?<descr>.+)
                    \.[^.]+
                  )
                )
                $
               }x.match(file)
        info = {}

        info['link'] = '/' + m[:link]
        info['descr'] = m[:descr]
        info['filename'] = m[:filename]

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

      # Return array not hash
      games.values
    end

  end

  class GenerateGames < Generator
    priority :high

    def generate(site)
      site.generate_games
    end
  end

end

