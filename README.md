
New Site!
=========

This is my new site made in Jekyll.

Sitemap
-------

    /
    /about
    /projects
    /books
    /blog
    /blog/:year/:month/:day/:title
    /blog/categories
    /blog/tags
    /blog/categories/:category
    /blog/tags/:tags
    /archive
    /404
    /wiki
    /wiki/*page
    /games
    /games/:title

    game ex:
    /games/sat-e/
    /games/sat-e/download/Linux_64bit-Sat-E_v1.0.tar
    /games/sat-e/download/Windows-Sat-E_v1.0.zip
    /games/sat-e/screenshot/Alone.png
    /games/sat-e/screenshot/Docking_Station.png
    /games/sat-e/screenshot/Lots_Of_Stuff.png


TODO
----

* Design!

* Fix highlighting + markdown for category/tag page

* Implement urls:

        /blog/:year
        /blog/:year/:month
        /blog/:year/:month/:day
        /sitemap + sitemap.xml
        /quotes

* Add in custom game files content
* Add in custom game screens content

* Remove the use of `<center>`! Deprecated since html 4.x or something...  
    Replace with `<div class="center">...</div>`

* Replace links in posts to relative links  
    /blog/ludum_dare_22_timelapse -> /blog/2011/12/19/ludum_dare_22_timelapse  
    etc...  
    A *lot* of links. Make script.

* Reroute domain names  
    Not possible to direct to bucket directly...  
    Possible with amazon service (cost 0.1$/month...)

* 301 redirects... How to handle?  
    Don't care?! :(


References
----------

Some plugin stuff modified from [here][black] and [here][jp].

[black]: http://github.com/BlackBulletIV/blackbulletiv.github.com
[jp]: http://recursive-design.com/projects/jekyll-plugins/

