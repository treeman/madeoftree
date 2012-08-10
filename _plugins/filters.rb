require 'uri'

module Jekyll
    module URI
        def uri_escape(input)
            URI.escape(input)
        end
    end
end

Liquid::Template.register_filter(Jekyll::URI)

