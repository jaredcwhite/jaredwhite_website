---
title: The Present Migration from Computer Networks to Person Networks
subtitle: Compared with what’s to come, everything you think you know about the “fediverse” to date is irrelevant.
cloudinary_id: wedding-at-cana
category: articles
date: 'Wed, 10 Jan 2024 09:25:08 -0800'
tags: Fediverse website
---

From the very beginning of the networked computer age, the canonical node in this network has been a computer. I know such an assertion sounds absurdly obvious—like *well duh Jared, everybody knows this!* But the key point you must grasp is that we're actually witnessing a major shift in progress, a migration if you will: from networks of computers to networks of people.

The social "networks" to which we've been accustomed to date weren't really networks in the true sense. Twitter in particular messed us up good—we viewed our `@username` handles as nodes in a vast global network, but in reality there was only ever one "computer" anyone could ever access in this scheme: twitter.com. In other words, everyone was logging into a single server and doing their work there. Everyone was `@username@twitter.com`. That's not a network. That's a mainframe. Which also means [it was a single point of failure](https://jaredwhite.com/articles/elongate).

Back in the 2000s, the blogosphere _almost_ became a true social network. person-a.com could "talk" to person-b.com by linking to them from a blog post, and person-b.com could link back in response. We even had technologies like [Trackbacks](https://en.wikipedia.org/wiki/Trackback) so blogs (people) could get notified of all these mentions. Unfortunately blogs eventually got overrun by spammers and bad actors, and thus everyone disabled trackbacks. And with that, the dream of the blogosphere as a social network died.

The ghost of Trackbacks was eventually resurrected as [Webmentions](https://en.wikipedia.org/wiki/Webmention), but I would argue that by this point in time, the "mainframes" of social media had won. Blog posts were only useful as _one-way destinations_, with social media and search being the mechanism to direct people to these destinations. Nobody "lived" on their blog anymore. They lived on social media, and directed people to their blog (to increasingly middling success).

### Death of the Mainframe

One could argue that the web's singular focus on servers hosting _documents_, instead of servers hosting _people_, brought us to this point where social media ate online identity. Expecting "homepages" (documents) to represent people turned out to be partially (but not entirely) a mistake.

What the web was missing, as it turns out, was a concept waiting in the wings all along—and in the guise of an email address-like syntax no less.

What the web needed was `@person@server.com`. _Viva la revolution!_

Taking a page from both email and social media, **the web itself needed handles**—and not single-part handles like on the mainframes but two-part handles with the username at the front, and the server at the back. **This subtle shift in thinking changes the whole nature of the game.** Because now you have a true global network. Each "server" (a cluster of servers under the hood perhaps, but that's an implementation detail) can now host a person's identity. That identity can then participate in the global network's _activities_ over time—whether that's sharing a link, posting a thought or a photo, publishing an article, upvoting a comment, you name it. (**Aside:** the importance of major organizations' ability to run these servers themselves and host/verify their members' identities in-house cannot be overstated. [Just ask the EU](https://social.network.europa.eu/about).)

In signing up to participate in this global user network, you have choice—choice like you've never had before. And the cool part is, if time passes and you come to realize you don't like the server you're on, you can move! If `@you@service-a.com` ends up sucking for some reason (enshittification, becomes a Nazi bar, owners decide to retire the server, etc.), you can simply migrate over to `@you@service-b.com`.

**No more single point of failure. No more mainframe trapping you so you can never leave.**

And if you want to get _really_ fancy, the servers on this new user network don't just have to be social media as we've known it. Yes, the Mastodons and the Pixelfeds of the world are super cool. But you know what's also cool?

Your website _as_ the server.

Imagine if `@jared@jaredwhite.com` were itself an identity on this global network. You could follow it (me). You could receive updates. You could comment on those updates.

I don't have this working today, because my site is a static site built with [Bridgetown](https://www.bridgetownrb.com) and doesn't speak the ActivityPub protocol. But it's a future I can definitely imagine. Other folks are already doing this courtesy of new tools like [WordPress' ActivityPub plugin](https://wordpress.org/plugins/activitypub/).

Honestly, I don't mind that my primary identity is [@jaredwhite@indieweb.social](https://indieweb.social/@jaredwhite). I like this server. I like the [guy who runs it](https://indieweb.social/@tchambers). It's all good.

### The Web is People

This global user network I keep referring to has been unofficially-officially branded as the **Fediverse** — but really it's just the World-Wide Web we all know and love with a few extra spices thrown into the mix. Instead of the web just being about documents, it's now about people too. Whereas `https://example.com/document.html` is a URL to a document, `@person@example.com` is a handle to a person (or a company, or an anonymous profile, or a bot, or a whatever). Both URLs and handles are now part and parcel of what makes the web _the web_. It's not one or the other. It's both.

**And that is incredibly, incredibly exciting.**

In [The Web is Fantastic](https://rknight.me/blog/the-web-is-fantastic/), Robb Knight writes:

> Don't give Facebook and the rest of these clowns your content. Don't give them the time or your attention. Get a blog, a website, a Mastodon account, something you control, and share links to cool things you find.

With the migration of more and more people to the person-based web, it opens up new opportunities to take the document-based web back to its roots and then push the envelope from there. [Blogging is back, baby](https://cdevroe.com/2023/01/11/blogging-is-alive). Newsfeeds are still a thing and still going strong. Podcasts have _always_ been [a pillar of the open web](https://jaredwhite.com/podcast/88/). Video streaming is, well, [a work in progress](https://jaredwhite.com/podcast/107/)…

In [ActivityPub will cross the chasm in 2024](https://cdevroe.com/2023/12/19/activitypub), Colin Devroe writes:

> In the near future, people won't need to know that these services use ActivityPub - they'll just browse around the web and follow whatever they want.

This is exactly right. For a long time, Mastodon=ActivityPub and ActivityPub=Mastodon. Even smart people writing for tech publications would routinely make this honest mistake.

**But the times they are a-changing.** ActivityPub is "eating the internet" and as more and more fediverse services come online, mainstream internet users will take advantage of this new person-based web without even realizing it. (If you want to be mesmerized, [watch this Discourse-Discourse-Mastodon ￼federation demo](https://meta.discourse.org/t/activitypub-plugin/266794/117). Mind-blowing stuff!)

Such a mass migration won't be easy though. There will be plenty of fits and starts and hiccups along the way. And even though we've been shocked to see THE social media company, Meta, embrace ActivityPub as a key marketing feature of its new social media platform Threads, I suspect many large platform owners will be dragged kicking and screaming into this new web. They don't want a web which features `@person@server.com` at its core. They want _everyone_ to remain `@person@shittymonopolisticsilo.com`.

They want all the eyeballs.

They want all the attention.

They want all the commerce.

They want all the control.

But just as the document web was _never_ about centralized control (the opposite in fact!) and we unfortunately got that anyway as a quirk of history, the person web has been designed from the get-go to offer decentralization as a feature not a bug.

Some folks out there claim mainstream users don't care about decentralization. They don't mind if they're subject to monopolistic control. **I beg to differ.** Mainstream users aren't clamoring for decentralization because _they don't know it's possible_. Many of them have only ever experienced an anomalous centralized document web. In this world the "web" is Facebook and Instagram and Google and YouTube and TikTok.

But that's not a web. That's a tiny constellation of corporate mainframes. Why have we put up with it? We put up with it because the person web hadn't been invented yet. We couldn't imagine how a mass migration from a document-based web dominated by a few servers to a person-based web spread across countless servers would work, _if it could work at all_.

**We're just starting to find out.** And that's the immense opportunity we see before us in 2024.

_Everything you know about the fediverse to date is irrelevant compared with what's to come._

That's why any noise you may be currently hearing about the relevance of any particular server or software on the network is just that. Noise. "Mainstream users don't care about Mastodon!" someone will wail.

**They don't need to.**

That's the beauty of the fediverse. _Every_ single SERVER. _Every_ single SERVICE. _Every_ single PERSON on this new person-based web. They all add value. **Every single damn one.**

It's exponential growth like we haven't seen since the very beginning of the web. And thus _you ain't seen nuthin' yet._

**The migration has only just begun.**

<br/>

_Featured painting: [The Marriage Feast at Cana by Juan de Flandes](https://www.metmuseum.org/art/collection/search/436801)_