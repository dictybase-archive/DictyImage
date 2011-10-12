 Module and scripts for generating image galleries for dictybase conference.

 ## Install dependencies 
 * cpanm --installdeps --local-lib-contained local .
 * Install a older version of mojolicious separately if the current one fails

 ## Resize images
 * perl -Ilocal/lib/perl5 script/resize_images <image_folder>
 ** It will generate two different sizes of pictures

 ## Generate html for image gallery
 * perl -Ilocal/lib/perl5 script/mk_adgallery_dicty.pl <image_folder>

 ## Copy the required js,css and image files to the web server path from the public folder
 of this distribution
 The default paths ....
 * image: /assets/images/adgallery
 * css: /assets/stylesheets/adgallery
 * js: /assets/javascripts/adgallery

 ## Copy the gallery images to the web server path if needed
 The default is /images/conference/<year>. So for 2011 it is /images/conference/2011

 ## Add the paths to the web server configuration as neccessary
