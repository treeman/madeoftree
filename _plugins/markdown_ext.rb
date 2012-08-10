module Jekyll
    class MarkdownConverter
        alias :old_convert :convert

        def convert(content)
            # Add in gist #1 syntax to give a link to it.
            converted = old_convert content.gsub(/gist #(\d+)/, '[gist #\1](https://gist.github.com/\1)')

            # Add in youtube links after markdown so we only link youtube links
            # on a line surrounded by empty lines.
            converted.gsub(
                %r{<p>\s*http://www\.youtube\.com/watch\?v=(\S+)\s*</p>},
                '<iframe class="youtube-player" type="text/html"
                        width="600" height="385"
                        src="http://www.youtube.com/embed/\1"
                        frameborder="0">
                </iframe>')

            # This adds the gist #1 syntax.
            # old_convert content.gsub(/gist #(\d+)/, '[gist #\1](https://gist.github.com/\1)')
        end
    end
end

            # Embed youtube links
            #$content =~ s|
            #    <p>\s*\Qhttp://www.youtube.com/watch?v=\E(\S+)\s*</p>
            #|
            #    <iframe class="youtube-player" type="text/html"
            #            width="600" height="385"
            #            src="http://www.youtube.com/embed/$1"
            #            frameborder="0">
            #    </iframe>
            #|gx;

