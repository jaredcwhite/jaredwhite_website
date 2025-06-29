---
date: Sat, 28 Jun 2025 23:03:43 -0700
title: Changing Podcast Platforms
---

I'm in the process of really shaking up the JCU (**Jared Content Universe**) this summer, and one aspect of that which has become clear to me is I need to find a new podcast hosting platform.

Historically, my [Fresh Fusion podcast](https://jaredwhite.com/podcast) has been a hodgepodge of techniques: the MP3 files themselves are hosted on Amazon S3 (ugh, not a service I want to support anymore), the RSS feed and pages are hosted here on my static site, and I use a proxy in front of the S3 URLs in the form of [Blubry](https://blubrry.com) for analytics.

Meanwhile, two other podcasts I've worked on which are currently on hiatus, [Fullstack Ruby](https://www.fullstackruby.dev/topics/podcast) and [Just a Spec](https://justaspec.buzzsprout.com), are hosted on [Buzzsprout](https://www.buzzsprout.com)…except I use Fullstack Ruby for the episode pages and Buzzsprout itself for the Just a Spec website. 🤪

It's all a bit of a mess. While I do like Buzzsprout, it makes it hard to experiment with new podcasts over time because every single show is its own subscription. And while I like the idea of Blubrry as a way of adding analytics support to any set of podcast files, its UX leaves a lot to be desired (and also costs a small monthly fee).

All that to say: **I'm on the hunt for a new podcasting service with a single (low) price for an unlimited number of shows**, plus the very critical feature that it integrates well with [Buttondown](https://buttondown.com). For you see, dear reader, my recent efforts to record audio editions of my [Cycles Hyped No More](https://buttondown.com/theinternet) newsletter has made it crystal clear for me that **I freakin' love writing essays and also recording them as spoken word as part of a unified artifact**.

Anyway, I'm gearing up to do a whole lotta podcasting soon, and that means I need what is essentially the infrastructure for a podcast network. There are a couple of options I'm looking at, and once I have a clearer idea of how it all looks, I'll publish my findings here in a follow-up post!
