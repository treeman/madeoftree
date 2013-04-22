
New Site!
=========

This is my new website made in [Jekyll][] which is a static site generator.

[Jekyll]: http://jekyllrb.com/

Sitemap
-------

    /
    /about
    /projects
    /books
    /blog
    /blog/:year
    /blog/:year/:month
    /blog/:year/:month/:day
    /blog/:year/:month/:day/:title
    /blog/categories
    /blog/categories/:category
    /blog/tags
    /blog/tags/:tags
    /archive
    /404
    /wiki
    /wiki/*page
    /games
    /games/:title
    /sitemap

    game ex:
    /games/sat-e/
    /games/sat-e/download/Linux_64bit-Sat-E_v1.0.tar
    /games/sat-e/download/Windows-Sat-E_v1.0.zip
    /games/sat-e/screenshot/Alone.png
    /games/sat-e/screenshot/Docking_Station.png
    /games/sat-e/screenshot/Lots_Of_Stuff.png


TODO
----

* Projects ordered after latest change/update
* Github link, not only as git clone

* Write
    * Introductary home page header
    * Check about page
    * Website in readme (here!)
    * 404 header

* Remove 'General' from tags and categories

* Design!
    * Unreadable on mobile phone
    * Fix html5 markup for unsupportive browsers

    * Tagged as in posts
    * Delimiter (horisontal line?) between posts in listings
    * Code highlighting
        * Remove code borders, need background
    * Link styling
        * Change color when hovering
    * Size + color for headers in pages
    * Games
        * Better download styling
        * Style code links etc
    * Projects
        * Style repository link
        * Prettier download link
        * Bunch up projects, see - http://recursive-design.com/projects/
        * Icons for languages etc
    * Style unordered/ordered lists better
    * Wiki page
    * More color to header
    * Add a small banner-like image?
    * Pictures in footer
    * Funky looking 404 page
    * Main page split bottom links prettier
        * Display more posts to align with projects and games
    * Not as visible "Read more..."
    * Color scheme for site!
    * Highlight first post on home page
    * Github Code link for humans

* Implement urls:

        /sitemap.xml
        /quotes

* Better 404 page
    * List tags + categories?

* Check correctness of feed links

* Make `site --link test` check correct links inside `_site` instead of using a server.

* `site --game` to edit games

* Log script. Retrieve and store logs from s3 storage.

* Reroute domain names  
    Not possible to direct to bucket directly...  
    Possible with amazon cloud front (cost 0.1$/month...)

* 301 redirects... How to handle?  
    Don't care?! :(


References
----------

Some plugin stuff modified from [here][black] and [here][jp].

[black]: http://github.com/BlackBulletIV/blackbulletiv.github.com
[jp]: http://recursive-design.com/projects/jekyll-plugins/


Dependencies
------------

Jekyll
rdiscount
git
zip
pygments
