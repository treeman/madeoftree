require 'uri'
require 'rubygems'
require 'nokogiri'

module Liquid
    module StandardFilters

        def slugize(text)
            text.slugize
        end

        def link_category(category)
            "#{@context.registers[:site].config['category_dir']}/#{category.slugize}"
        end

        def link_tag(tag)
            "#{@context.registers[:site].config['tag_dir']}/#{tag.slugize}"
        end

        def length(obj)
            obj.length if obj.respond_to? :length
        end

        def uri_escape(input)
            URI.escape(input)
        end

        def truncatehtml(raw, max_length = 15, continuation_string = "...")
            doc = Nokogiri::HTML(Iconv.conv('UTF8//TRANSLIT//IGNORE', 'UTF8', raw))
            current_length = 0;
            deleting = false
            to_delete = []

            depth_first(doc.children.first) do |node|

                if !deleting && node.class == Nokogiri::XML::Text
                    current_length += node.text.length
                end

                if deleting
                    to_delete << node
                end

                if !deleting && current_length > max_length
                    deleting = true

                    # Will cut off words
                    #trim_to_length = current_length - max_length + 1
                    #node.content = node.text[0..trim_to_length] + continuation_string

                    # Don't cut off words etc
                    node.content = node.text + continuation_string
                end
            end

            to_delete.map(&:remove)

            doc.inner_html
        end

      private

        def depth_first(root, &block)
            parent = root.parent
            sibling = root.next
            first_child = root.children.first

            yield(root)

            if first_child
                depth_first(first_child, &block)
            else
                if sibling
                    depth_first(sibling, &block)
                else
                # back up to the next sibling
                n = parent
                while n && n.next.nil? && n.name != "document"
                    n = n.parent
                end

                # To the sibling - otherwise, we're done!
                if n && n.next
                    depth_first(n.next, &block)
                end
            end
        end

      end
    end
end

