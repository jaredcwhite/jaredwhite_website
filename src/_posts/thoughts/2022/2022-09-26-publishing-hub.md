---
date: 'Mon, 26 Sep 2022 09:42:21 -0700'
title: The Blog as Publishing Hub
published: true
category: thoughts
tags: openweb website
---

**Blog**: short for **Web-log**. A personalized record of content you post on the web.

**Web**: a shortening of **World-Wide Web**. A global network of hypertext documents all linking to each other.

So then, why is it rare to find anyone actually doing this with their blog? 🤔

There's a term in IndieWeb circles called [Publish (on your) Own Site, Syndicate Elsewhere](https://indieweb.org/POSSE) (or **POSSE**). It sort of captures an aspect of that idea…basically you use your own blog to publish thoughts, link commentary, photos, videos, newsletters, etc., and then disseminate that content out to other services (YouTube, Twitter, mailing lists, your own RSS feed, etc.)

I tried **POSSE** in a previous incarnation of this site. _I ended up not liking it._ It doesn't capture the workflows I instinctively prefer on a regular basis, nor how I wish the #openweb really functioned.

What I want to do is the exact opposite! IndieWeb also provides a term for this: [Publish Elsewhere, Syndicate (to your) Own Site](https://indieweb.org/PESOS) (or **PESOS**). They don't recommend it, and the wiki page enumerates some of the reasons why. But I have come to realize I prefer **PESOS** for a lot of the content I produce, because it's generally _way_ easier and the UX is _way_ better.

* I _like_ "microblogging" on Twitter.
* I _like_ posting videos on YouTube.
* I _like_ writing newsletter issues in [ConvertKit](https://convertkit.com).
* I _like_ uploading podcast episodes to [Buzzsprout](https://buzzsprout.com). (I don't for this site, but I do use it for the [Fullstack Ruby](https://www.fullstackruby.dev/topics/podcast) podcast.)
* I _like_ posting photos on…well, certainly not Instagram any more. 😂 [Glass](https://glass.photo) is pretty rad, but I haven't determined if I want to reserve it for the "fancy" photos I take with my "fancy" camera, or simply give up and flood it with on-the-go iPhone snaps.
* I _like_ [releasing music](https://yarred.bandcamp.com) on Bandcamp. (Honestly, I don't know of any indie musician who _doesn't_ use Bandcamp at this point!)

So the question then becomes: how do I post all this content elsewhere, then _transparently_ pull in links and import content back to my own #website? Of course on a technical level, it means I'll be writing lots of Ruby plugins for [Bridgetown](https://www.bridgetownrb.com), the software I use to build my website. But I'm always musing on workflows that can be easily applied to _the industry of blogging_ as a whole. I haven't seen much evidence anyone's truly cracked this nut. Also admittedly, dragging your own content in kicking and screaming from third-party silos is often less than straightforward (hence the notion of **POSSE**), because they have a vested interest _not_ to let you feature your own content on your own website. (YouTube remains sort of a weird outlier here because they make it easy to embed videos anywhere, and [youtube-dl](https://youtube-dl.org) is certainly a thing.)

Still, I'm motivated to figure this stuff out. I'll let you know how it goes! ☺️
