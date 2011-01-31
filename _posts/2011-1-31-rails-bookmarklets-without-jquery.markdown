---
layout: post
title: Rails Bookmarklets without jQuery
---


The purpose of this article is to explain how I created the bookmarklet for <a href="http://readingtime.me">readingtime.me</a>.  I wanted the bookmarklet to be as light and simple as possible. Simple also requires that no external libraries are required as well, hence the without jQuery part.

##Link Generation

The first thing to do is create a piece of javascript that will load in the javascript file that you want to execute on the page.

{% highlight js %}
var s = document.createElement('script');
s.setAttribute('language','javascript');
s.setAttribute('src','http://example.com/js/bookmarklet.js');
document.body.appendChild(s);
void(0);
{% endhighlight %}

I went with the most simple solution.  The above script simply injects a new script on the user's current page.  The browser will then automatically load that script.  Once that is complete you need to run that through something that will strip out all the new lines and bad characters.  I found a <a href="http://daringfireball.net/2007/03/javascript_bookmarklet_builder">script from daring fireball</a> that does just that.  Stick the output into a anchor tag and your good to go.

##Rails Javascript Generation

I wanted to be able to render things inside my javascript file so I created a controller that had a single action bookmarklet.  They controller also set the layout to false so that it would only render the js file. 


{% highlight ruby %}
class JsController < ApplicationController
  layout false

  def bookmarklet 
  end
end

#routes.rb
get "js/bookmarklet(.:format)" => "js#bookmarklet", :as => :bookmarklet
{% endhighlight %}

Rails will take care of serving the proper file type with the format included in the route.  The view consists of a standard js.erb file listed bellow (excuse the extended long lines):

{% highlight js %}
(function() {
  function create_container(id) {
    var container = document.createElement("div");
    container.id = id;
    container.innerHTML = "<%= escape_javascript(render( :partial => "shared/ui", :locals => {:api_key => params[:k]}))%>";
    document.body.appendChild(container);
  };

  function save_link() {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "<%= links_create_url(:format => 'js') %>?callback=save_link_complete&api_key=<%= params["api_key"] %>&link[url]=" + encodeURI(window.location.href);
    script.id = "readingtime-loadJSONP";
    document.body.appendChild(script);
  }
  
  create_container("readingtime-container");
  save_link();
})();

function save_link_complete(data) {
  if(data.status == "success") {
    set_status("<%= escape_javascript(render("shared/saved")) %>");
  } else {
    set_status("<%= escape_javascript(render("shared/error")) %>");
  }

  var s = document.getElementById("readingtime-loadJSONP");
  s.parentNode.removeChild(s);

  setTimeout(close_container, 750);
}

function set_status(content) {
  document.getElementById("readingtime-status").innerHTML = content;
}

function close_container() {
  var container = document.getElementById('readingtime-container');
  container.style.display = 'none';
  container.parentNode.removeChild(container);
}

{% endhighlight %}

The first two functions create_container and save_link do the following.  Create container adds a new div to the user's page.  Within that div I render the content of a rails partial which contains the UI of the bookmarklet. 

The next function save_link performs a JSONP style request.  We basically inject another script tag into the document and that script tag will perform a get request to our server.  Our server will then respond with a callback that has the arguments of the server's response.  This enables us to bypass any cross domain security violations. 

After we receive the response from teh server our callback save_link_complete will be called and then we display that information to the user. After that we wait for 3/4 of a second then close the view.  We could do some fancy fade out or slide out but I wanted the bookmarklet to feel snappy and fast.

## Conclusions

The goal was to create something that solves my bookmarklet problem in the simplest possible way.  I'm not a fan of over engineering things until they need to be. I believe I met this goal and the bookmarklet has been tested on Firefox, Chrome, Safari.

If you have any questions or improvements please email me.  I will be very happy to answer anything that I may have missed in this explanation or be wiling to change any errors that I may have produced. I hope you found this informative and I wish you the best of luck with your projects.
