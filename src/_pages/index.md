---
# Feel free to add content and custom Front Matter to this file.

layout: default
---

## Hello and Welcome! <sl-icon library="remixicon" name="{{ "destinations.home.icon" | t }}"></sl-icon>

I’m Jared, an award-winning **essayist**, **Rubyist**, and **podcaster** who’s been commenting on and building for the web since Mosaic was a thing. (Yup, it’s true! 😆)

In my spare time I travel around **Portland** 🌲 and the Pacific Northwest and shoot cinematic-yet-quirky vlogs. 📹 📺 &nbsp;In addition, I compose and produce 80s-flavored **retro electronica**. 🎹 🎶

This is my **home base** on the internet. I hope you enjoy browsing around! 📍

**P.S. What am I doing now? [That's what the Now Page is for!](/now)** ⏱

**P.P.S. What’s my favorite (fill-in-the-blank)? [Find out in About Me.](/about)** 😃

----

## Things I Do <sl-icon library="remixicon" name="{{ "destinations.projects.icon" | t }}"></sl-icon>

It would seem I'm always but one step away from reaching for an endeavor to occupy my time with at any given moment. Besides what's obviously available on this website…from Bridgetown, a Ruby-powered site generator, to Yarred, my musical alter-ego, there's something for…well…somebody.

**[Welcome to the Jaredverse!](/projects)** 😌

----

## Newest Posts <sl-icon library="remixicon" name="{{ "categories.links.icon" | t }}"></sl-icon>

<resources-feed skip-last-hr>
  {% collections.posts.resources.reject { |r| %w(pictures videos).include?(r.data.category) }[0...4].each do |resource| %}
    {%@ Resources::BaseComponent.component_for_resource(resource) resource: resource, h_level: :h3 %}
  {% end %}
</resources-feed>

<p style="text-align:center; margin-bottom:3.5rem"><a class="button" href="/posts">
  More Posts This Way
  <sl-icon style="font-size:1.1em; vertical-align:-4px" library="remixicon" name="system/arrow-right-circle-line"></sl-icon>
</a></p>

----

<a-card>
  {%@ "newsletter_preamble" %}
  {%@ "newsletter_form" %}
</a-card>

----

## Photos <sl-icon library="remixicon" name="{{ "categories.pictures.icon" | t }}"></sl-icon>

<resources-feed skip-last-hr>
  {% collections.posts.resources.select { |r| r.data.category == "pictures" }[0...3].each do |resource| %}
    {%@ Resources::BaseComponent.component_for_resource(resource) resource: resource, h_level: :h3 %}
  {% end %}
</resources-feed>

<p style="text-align:center; margin-bottom:3.5rem"><a class="button" href="/browse/pictures">
  More Photos This Way
  <sl-icon style="font-size:1.1em; vertical-align:-4px" library="remixicon" name="system/arrow-right-circle-line"></sl-icon>
</a></p>

----

## Podcast <sl-icon library="remixicon" name="{{ "destinations.podcast.icon" | t }}"></sl-icon>

<a-card style="margin-bottom:3rem">
  {%@ "podcast_subscriptions" %}
</a-card>

<resources-feed skip-last-hr>
  {% collections.podcast.resources.first.tap do |resource| %}
    {%@ Resources::EpisodeComponent resource: resource, h_level: :h3 %}
  {% end %}
</resources-feed>

<p style="text-align:center; margin-bottom:3.5rem"><a class="button" href="/podcast">
  More Episodes This Way
  <sl-icon style="font-size:1.1em; vertical-align:-4px" library="remixicon" name="system/arrow-right-circle-line"></sl-icon>
</a></p>

----

## Videos <sl-icon library="remixicon" name="{{ "categories.videos.icon" | t }}"></sl-icon>

<resources-feed skip-last-hr>
  {% collections.posts.resources.select { |r| r.data.category == "videos" }[0...2].each do |resource| %}
    {%@ Resources::BaseComponent.component_for_resource(resource) resource: resource, h_level: :h3 %}
  {% end %}
</resources-feed>

<p style="text-align:center; margin-bottom:3.5rem"><a class="button" href="/browse/videos">
  More Videos This Way
  <sl-icon style="font-size:1.1em; vertical-align:-4px" library="remixicon" name="system/arrow-right-circle-line"></sl-icon>
</a></p>

----

## Popular Essays <sl-icon library="remixicon" name="{{ "categories.articles.icon" | t }}"></sl-icon>
{:style="white-space:nowrap"}

<resources-feed skip-last-hr>
  {% collections.posts.resources.select { |r| r.data.favorite }.each do |resource| %}
    {%@ Resources::BaseComponent.component_for_resource(resource) resource: resource, h_level: :h3 %}
  {% end %}
</resources-feed>
