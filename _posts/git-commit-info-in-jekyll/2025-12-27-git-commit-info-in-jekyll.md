---
title: running bash commands in jekyll (plus git commit info)
series: makin the blog
tags: [git, bash, linux, jekyll, commit, ruby, blog]
---

I started vibe-coding a little jekyll extension in Ruby to embed the git commit sha and timestamp into the blog, then accidentally came up with something even cooler.

## the original goal - git info in the jekyll build output

When I push a change to the site, github takes a minute to build and publish the new version. I have to either manually navigate to the github page and watch the build-status, or refresh the webpage over and over to see if it's changed yet, and make sure the browser isn't caching it, etc... And for subtle or invisible changes, this can be even trickier to tell if it's changed yet.

I wanted to be able to have the sha and timestamp from the git commit embedded somewhere in the webpage where I could quickly check it.

I frequently embed the short commit hash in the build artifacts of other projects I work in, even the firmware ones. I find that it's a more reliable way to track what code a software build was made from than a build number (which can be arbitrary and require manual association with a commit) or a version number (which typically requires manual updating and only gets changed at a formal release time). With this I can literally generate a URL that links back to that commit on github.

I also like to append a `-dirty` suffix to the sha if there are any untracked changes.

## the original solution

Since I'm not familiar with Ruby, I used a little extra AI help to quickly figure out the script. It was also helpful for figuring out the exact git log commands to get the timestamp in my preferred timezone.

<div>
For now it's on the <a href="{{"/about" | relative_url}}">about</a> page so I can be sure of what version of the site I am looking at.
</div>

### the git jekyll code

```ruby
{% run_cmd cat _plugins/git_commit.rb %}
```

## the next goal - embedding code

While starting to write this blog post, I was trying to figure out how best to embed or include the plugin code into the post. I _could have_ just copied and pasted the code, as it currently is, into this post inside a code tag and be done with it...

But I have the file right here - why can't I embed it somehow? However, since it's in a directory with an underscore, jekyll won't include it in the output by default.

Maybe I could just include the plugins folder manually? But that seems too heavy-handed, and I don't want to be dumping other unnecessary files into the build output.

Since I'm including files relative to my posts with the jekyll-postfiles extension, maybe I could just symlink the file into this directory? Nah, that didn't seem to work - the symlink was getting copied instead of the file... Maybe I could go the other way around, and have the actual code in this directory and have a symlink in the plugins folder to the file here? But that seems like poor organization and pretty brittle to have my actual code living inside some random blog post.

I started exploring some other relative-include solutions and found one that mentioned executables. Hmm, this got me thinking - could I just call `cat _plugins/...` from within the jekyll file? Or any other bash command?

Imagine the possibilities... I could invoke some build steps in other languages, or even fetch remote content and pipe it right into my markdown.

## the bonus solution - executing system commands from within jekyll

Here's the code I came up with to create a `run_cmd` liquid tag that allows me to straight-up run commands and put their stdout output in the pre-rendered jekyll files.

```ruby
{% run_cmd cat _plugins/run_cmd.rb %}
```

And here's the markdown/liquid i had to write to generate the code block above:

````liquid
```ruby
{% raw %}{% run_cmd cat _plugins/run_cmd.rb %}{% endraw %}
```
````

Side-note - to generate this second code block, I had to escape the liquid using `raw` / `endraw`.

I could even use this to replace the git plugin I just made. I'll get around to that later...

And just for the hell of it, here's the output of the `grep --version` command for the runner that's built the file you're reading right now (e.g. `run_cmd grep --version` wrapped in liquid brackets, wrapped in a markdown code fence):

```txt
{% run_cmd grep --version %}
```
