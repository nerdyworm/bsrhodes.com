---
layout: post
title: Testing Syntax Highlighting
---

Hi

{% highlight ruby %}
puts "hi tehre"
puts (1..23).collect{|i| puts i}
{% endhighlight %}


{% highlight ruby %}
def taggies
  names = []
  self.tags.each do |tag|
    names << tag.name
  end
  names.join(', ')
end

def taggies=(tags)
  handle_tag_s(tags)
end

def handle_tag_s(comma_del_tags)
  comma_del_tags.split(',').each do |name|
    name = name.strip
    tag = Tag.find_by_name(name)
    if tag.nil?
      tag = Tag.create(:name => name)
    end
    self.tags << tag
  end
end

task :after_update_code do
    run "ln -s #{shared_path}/uploads/ #{release_path}/public/uploads"
end
{% endhighlight %}
