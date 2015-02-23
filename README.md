# hippo-shared-content
Set up for Hipp project with shared content

# Reuse of content


The Hippo project contains a setup for sharing content in Hippo. The setup consists of one corporate site and 3 subsites named een, twee, drie.
The search on the corporate site shows the news documents of the subsite with context aware links.
The search on the subsites show the news documents within the context of the subsite.

# Search in a subsite :

http://localhost:8080/site/twee/search?query="medusa"

The search results on the subsite are within the context of the subsite, for instance:



# Search in the corporate site :

If you search on corporate you get results of all the sites : http://localhost:8080/site/corporate/search?query=%22medusa%22

The search results on the corporate are within the context of the corporate site, for instance:

http://localhost:8080/site/corporate/news/drie/news/2015/02/the-medusa-news.html

The link of the same document in the subsite drie is : http://localhost:8080/site/drie/news/2015/02/the-medusa-news.html


# How to create a new subsite (www.example.com)  :

1)  Set in your /etc/hosts the following line:
    127.0.0.1 www.example.com

2) Build and start
   mvn clean install
   mvn cargo.run -Drepo.path=storage

3) check http://localhost:8080/site/corporate/search?query=%22medusa%22 and  http://localhost:8080/site/drie/news/2015/02/the-medusa-news.html

4) Console. Add under hst:hosts 3 hst:virtualhosts nodes:
      -- com
          -- example
              -- www


5) Add under node "www" a mount with name hst:root. Do not yet set any properties on the mount.

6) Go to content/documents/corporate and copy one of the subsites content folders and call the new folder www-example-com.
Login the CMS. Open the news document /content/documents/corporate/www-example-com/news/2015/02/the-medusa-news and set
the title to the medusa news - Site # www-example-com and publish

7) Go back to the console/ Make a hst:site node under hst:sites named wwwexamplecom and set the hst:content to /content/documents/corporate/www-example-com.

8) Make a new hst:channel under hst:channels named wwwexamplecom and set the property hst:name to www.example.com.

9) Set the following properties on the mount com/example/www/hst:root

- hst:channelpath : /hst:hst/hst:channels/wwwexamplecom
- hst:mountpoint : /hst:hst/hst:sites/wwwexamplecom
- hst:alias : wwwexamplecom
- hst:locale : nl_NL

10) Make a new hst:configuration under hst:configuration - copy one of the existing subsite hst:configuration, for instance
wkmultidrie and name it wwwexamplecom.

11) Go to the template search-main under wwwexamplecom/hst:templates and set the hst:renderpath to freemarker/wkmulti/wwwexamplecom/search-main.ftl

12) Go to hst:configuration/corporate/hst:sitemap/news/. Copy one of the hst:sitemaps (for instance drie)
to a new hst:sitemap named www-example-com. Set the hst:relativecontentpath of the news sitemap item to www-example-com/news

13) Stop the CMS. Add a freemarker template for the search of the new site www.example.com. The template is
freemarker/wkmulti/wwwexamplecom/search-main.ftl and set the mount variable of the link in the template to "wwwexamplecom"

<@hst.link var="link" hippobean=item mount="wwwexamplecom" />

14) Build the site and startup with mvn -P cargo.run -Drepo.path=storage
In the browser open http://www.example.com:8080/site/

15) Check the search on http://www.example.com:8080/site/search?query=%22medusa%22.
The url of the found document is http://www.example.com:8080/site/news/2015/02/the-medusa-news.html

16 ) Check the global search http://localhost:8080/site/corporate/search?query=%22medusa%22. Results are found for
 all the subsites. Check the url of the found news document for www.example.com is in the context of the corporate site









