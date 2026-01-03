---
title: jekyll build-time assertions
series: makin the blog
tags: [jekyll, liquid, ruby, blog, coding]
---

Why not catch errors at build-time, rather than run-time (or not at all)?

## the problem

Jekyll / liquid doesn't seem to have any built-in assertion mechanism. There are some plugins for schema validation and things like that, but I wanted something really basic and flexible - e.g. `assert a == b, "Error, a is not equal to b!"`.

I'm a firm believer in catching errors as early as possible, during build-time rather than runtime. Not only does it prevent the bad condition from ever happening to begin with, but it reduces bloat in the build output because that check doesn't need to exist anymore at runtime.

I've worked on some large firmware projects where they stubbed out unimplemented methods with runtime `ASSERT(false)` and this drove me insane! It's C... why not just **not define** those methods for that particular platform? If nothing is calling them, then the linker won't care. And if something does call them - what are we doing?

<iframe src="https://www.youtube.com/embed/s7wLYzRJt3s?si=B82JiF9gvKhdtACN" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

> "Runtime error is the responsibility of the user"

But I'm getting off topic...

Anyways, I was just adding links to the header bar of the blog, and wanted to just grab all pages that have a `nav_order` attribute (which indicates they should be in the nav-bar and what order they should be in) and also assert that those pages in particular have a title.

Here's what I came up with:

[\_plugins/assert_filter.rb](https://github.com/r-downing/mk-sth/blob/main/_plugins/assert_filter.rb)

```ruby
{% run_cmd cat _plugins/assert_filter.rb %}
```

I used a filter rather than a tag because a tag would require manually splitting and parsing the condition and the message. Since I can't get the context and file / line-number with a filter, I made the message string required.

It's not very advanced, but I can easily use it to prevent things from failing silently.
