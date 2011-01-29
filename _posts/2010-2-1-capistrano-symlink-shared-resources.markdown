---
layout: post
title: "Capistrano: Symlink shared resources"
---

Personal note to self.  When deploying with capistrano and local uploads you need to have a shared path and symlink to files.

{% highlight ruby %}
task :after_update_code do
    run "ln -s #{shared_path}/uploads/ #{release_path}/public/uploads"
end
{% endhighlight %}
