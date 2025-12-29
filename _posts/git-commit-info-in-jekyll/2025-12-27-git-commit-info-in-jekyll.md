---
title: git commit info in jekyll
series: makin the blog
tags: [git, jekyll, commit, ruby, blog]
---

I vibe-coded a little jekyll extension in Ruby to embed the git commit sha and timestamp into the blog.

## the problem

When I push a change to the site, github takes a minute to build and publish the new version. I have to either manually navigate to the github page and watch the build-status, or refresh the webpage over and over to see if it's changed yet, and make sure the browser isn't caching it, etc... And for subtle or invisible changes, this can be even trickier to tell if it's changed yet.

I wanted to be able to have the sha and timestamp from the git commit embedded somewhere in the webpage where I could quickly check it.

I frequently embed the short commit hash in the build artifacts of other projects I work in, even the firmware ones. I find that it's a more reliable way to track what code a software build was made from than say a build number (which can be arbitrary and require manual association with a commit) or a version number (which typically requires manual updating and only gets changed at a formal release time). With this I can literally generate a URL that links back to that commit on github.

I also like to append a `-dirty` suffix to the sha if there are any untracked changes.

## the solution

Since I'm not familiar with Ruby, I used a little extra AI help to quickly figure out the script. It was also helpful for figuring out the exact git log commands to get the timestamp in my preferred timezone.

<div>
For now it's on the <a href="{{"/about" | relative_url}}">about</a> page so I can be sure of what version of the site I am looking at.
</div>
