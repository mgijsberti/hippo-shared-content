Reuse of content
===============

The site contains four subsites, corporate, een, twee, drie and test. The search on the corporate site shows the
news documents of the subsite with context aware links. The search on the subsites show the news documents
within the context of the subsite.

Search in a subsite :
====================

http://localhost:8080/site/twee/search?query=%22medusa%22

The search results on the subsite are within the context of the subsite, for instance:



Search in the corporate site :
=============================

If you search on corporate you get results of all the sites

http://localhost:8080/site/corporate/search?query=%22medusa%22

The search results on the corporate are within the context of the corporate site, for instance:

http://localhost:8080/site/corporate/news/drie/news/2015/02/the-medusa-news.html

The link of the smae document in the subsite subsite is :

http://localhost:8080/site/drie/news/2015/02/the-medusa-news.html


How to create a new subsite (www.example.com)  :
===============================================

1)  Set in your /etc/hosts the following line:
    127.0.0.1 www.example.com

2) Add under hst:hosts three hst:virtualhosts nodes in this order:
      -- com
          -- example
             -- www


3) Add under node www a mount with name hst:root. Do not yet set any properties on the mount.

4) Now go to content/documents/corporate and copy one of the subsites content folders and call the new folder www-example-com
Open the news document /content/documents/corporate/www-example-com/news/2015/02/the-medusa-news and set the title to
The medusa news - Site # www-example-com and publish

5) Make a hst:site under hst:sites named wwwexamplecom and set the hst:content to /content/documents/corporate/www-example-com

6) Make a new hst:channel under hst:channels named wwwexamplecom and set the property hst:name to www.example.com

7) Set the following properties on the mount com/example/www/hst:root

- hst:channelpath : /hst:hst/hst:channels/wwwexamplecom
- hst:mountpoint : /hst:hst/hst:sites/wwwexamplecom
- hst:alias : wwwexamplecom
- hst:locale : nl_NL

8) Make a new hst:configuration under hst:configuration - copy one of the existing subsite hst:configuration, for instance
wkmultidrie and name it wwwexamplecom.

9) Go to the template search-main under wwwexamplecom/hst:templates and set the hst:renderpath to freemarker/wkmulti/wwwexamplecom/search-main.ftl

10) Go to hst:configuration/corporate/hst:sitemap/news/ and copy one of the subsite configuration (for instance drie)
to www-example-com. Set the hst:relativecontentpath of the news sitemap item to www-example-com/news

11) Stop the CMS and add a freemarker template for the search of the new site www.example.com. The template is
freemarker/wkmulti/wwwexamplecom/search-main.ftl and set the mount variable of the link in the template to "wwwexamplecom"

<@hst.link var="link" hippobean=item mount="wwwexamplecom" />

12) Build the site and startup on http://www.example.com:8080/site/

13) Check the search on http://www.example.com:8080/site/search?query=%22medusa%22.
The url of the found document is http://www.example.com:8080/site/news/2015/02/the-medusa-news.html

14 ) Check the global search http://localhost:8080/site/corporate/search?query=%22medusa%22. Results are found for
 all the subsites. Check the url of the found news document is in the context of the corporate site, for instance
 under www.example.com : http://localhost:8080/site/corporate/news/drie/news/2015/02/the-medusa-news.html







