---
layout: post
title: Mac Like Text Editing Keybinds
---
When switching to ubuntu 10.04 I ran into something that made me uncomfortable, no alt+left and alt+right to skip between words.

It took a decent amount of googling but I finally found a solution to the problem on the <a href="http://ubuntuforums.org/showthread.php?p=7522446">ubuntu forums</a>.

{% highlight sh %}
# /usr/share/themes/Mac/gtk-2.0-key/gtkr
# Mac-like text editing keybindings

binding "gtk-mac-text-entry"
{
  bind "<ctrl>Left" { "move-cursor" (display-line-ends, -1, 0) }
  bind "<shift><ctrl>Left" { "move-cursor" (display-line-ends, -1, 1) }
  bind "<ctrl>Right" { "move-cursor" (display-line-ends, 1, 0) }
  bind "<shift><ctrl>Right" { "move-cursor" (display-line-ends, 1, 1) }

  bind "<ctrl>Up" { "move-cursor" (buffer-ends, -1, 0) }
  bind "<shift><ctrl>Up" { "move-cursor" (buffer-ends, -1, 1) }
  bind "<ctrl>Down" { "move-cursor" (buffer-ends, 1, 0) }
  bind "<shift><ctrl>Down" { "move-cursor" (buffer-ends, 1, 1) }

  bind "<alt>Left" { "move-cursor" (words, -1, 0) }
  bind "<shift><alt>Left" { "move-cursor" (words, -1, 1) }
  bind "<alt>Right" { "move-cursor" (words, 1, 0) }
  bind "<shift><alt>Right" { "move-cursor" (words, 1, 1) }
}

class "GtkEntry" binding "gtk-mac-text-entry"
class "GtkTextView" binding "gtk-mac-text-entry"
{% endhighlight %}

Run the <span style="font-family: monospace">gconf-editor</span> command from a terminal and set the value of /desktop/gnome/interface/gtk_key_theme to “Mac.” The Mac correspond the the theme folder you placed your gtkr file in.

Enjoy your mac like text editing!

Once again thanks to dansmith of the ubuntu forums.
