---
date: Thursday, April 11, 2024 at 11:34:07 AM PDT
category: articles
cloudinary_id: preset-galaxy-hero_z0lkqn
cloudinary_quality: 75
title: "Hailing Music Producers Throughout the Quadrant! Preset Galaxy Has Liftoff"
subtitle: It's not every day I get to talk about a new UGC platform I've collaboratively built in my freelancing role at Whitefusion. Here's how it all came about.
tags: freelancing synthmusic
---

In my line of work as a software developer at [Whitefusion](https://www.whitefusion.studio), a boutique web studio based in Portland, Oregon, I typically engage with two very different sorts of projects:

* **Passion projects.** These are the technologies, publications, and marketable activities I participate in as an "industry notable". Open source software tools, blogs, educational materials, community groups & tech meetups…that sort of thing.
* **Client projects.** These are the projects I'm hired to work on which pay the bills and let me utilize my skills as a programmer & UX designer to solve real-world problems on production codebases.

Now I would be misrepresenting these scenarios if I let you walk away believing passion projects are always fun (_sometimes they're a real slog!_), or that client projects are always difficult and zap all the joy out of life (_truly, I've worked with some awesome clients on exciting projects which have taught me a ton!_).

Nevertheless, I primarily talk in public about my passion projects and not my client projects, because I generally consider the importance of maintaining confidentially for all my clients to be paramount. Often I'm working on internal business applications, or on startup products (and unfortunately software startups don't have a stellar success rate), or on projects where I've come in as a subcontractor working on behalf of another agency. So while I'll talk about the technical findings and business acumen I've gleaned while working on these projects, I almost never have occasion to bring them up directly in public discourse.

And then—_once in a great while_—**the two worlds collide**. Ooo…a client project which I'm authentically passionate about _and_ get to talk about publicly?! _Huzzah!_

**Today, that project is [Preset Galaxy](https://www.presetgalaxy.com).**

(Before I go on, I want to be crystal clear this is not a sponsored post or yet more shameless marketing. I truly believe in the project, and the company behind it rocks. 🤘)

### A Universe of Sound

So what is **Preset Galaxy**? As it says on the tin, it's "the thrilling new destination for finding and sharing presets for all your favorite software synthesizers and samplers." I [wrote in our official launch post](https://blog.presetgalaxy.com/preset-galaxy-blast-off/):

> In observing the landscape of online resources for fans of computer music technology, we noticed there wasn't a central place where musicians, producers, and sonic innovators could all come together to form a community around presets. Sure, you could find presets lurking about—a forum here, a chat room there, some extension of some other website about electronic music, or a particular manufacturer's online community. But Preset Galaxy is all about the presets. That's it. That's the toot. 🎺

The idea and featureset for Preset Galaxy was conceived by **Greg Schlaepfer**, the founder of well-known sample library producer [Orange Tree Samples](https://www.orangetreesamples.com/). I've personally known Greg for basically forever, and I'd also worked with him once before in the early 2010s to record and release the [MesaWinds sample library](https://www.orangetreesamples.com/products/mesawinds). I'm immensely grateful we were able to stay in touch over the decades.

So when Greg approached me a few years ago with the idea of a community platform for uploading and sharing presets relevant for all manner of synthesizer and effects plugins, **I leapt at the chance**.

<figure style="margin-inline: 0; text-align: center" markdown="block">
![Spider-Man meme with caption You know, I'm something of a musician myself](/articles/something-of-a-musician.jpg)
</figure>

As [something of a musician myself](https://www.yarred.com), I understood the value of musicians and producers being able to share the sounds they've created in various plugins. I've benefited from **"user-generated content"** many times before, whether that's presets, samples, and other music production tools. This was an exciting opportunity in an industry I was familiar with—not always a privilege you get with projects sent your direction as a freelancer.

As the project got underway, I was a bit daunted by the thought that I was working on this entirely as a **solo developer**. I'd never built a large-scale UGC (User-Generated Content) platform from scratch before, and it seemed like I could easily get mired in technical details and lose sight of the overall user experience and product-market fit. Thankfully a designer came aboard early on, Hannes Pasqualini of [Papernoise Design](https://www.papernoise.net), to help flesh out the personality and "vibe" of the site (and of course the logo and character design of the **Preset Galaxy** brand). This was instrumental in informing my subsequent interface work and making sure the site would feel inviting and fun for musicians.

<figure markdown="1">
![Space Man rockin' out with their keytar](https://www.presetgalaxy.com/assets/spaceman-illustration-4bd629afa16578707cd390904a9111f97c9ec94f.jpg){: style="mask-image: radial-gradient(circle, black 56%, rgba(0, 0, 0, 0) 69%);
shape-outside: circle(50%)"}
</figure>

### The Technical Deets

Feel free to skip over this section if you're not a web developer. 🤓

**Let's start on the backend.** As a [long-time fan of the Ruby programming language](https://www.fullstackruby.dev), I naturally gravitated towards using Ruby as the basis of our tech stack. While I spend a lot of my time now working on solutions atop [Roda](https://roda.jeremyevans.net), we decided on the battle-hardened and well-understood Rails framework which is well-suited to the needs of a UGC platform like Preset Galaxy.

I'm definitely using Rails in some novel ways though (surprise surprise 😉️). Here are some of those "outside the box" technologies & techniques:

* [Serbea](https://www.serbea.dev): This is one of my own Rubygems. I like to think of Serbea as a "superset" of ERB. It uses braces {% raw %}(`{%` and `%}`){% endraw %} instead of angle brackets for delimiters, which I find _vastly preferable_ for an HTML template language. In addition, Serbea offers a pipeline syntax similar to Liquid, Nunjucks, etc. While Serbea 2.0 does offer a `pipe` method even for ERB users, I just like using the simplest syntax possible. And in a Rails context you can actually write "front matter" in your view templates, passing things like page titles and layout directives directly to parent layouts in Rails.

* [Lifeform](https://github.com/bridgetownrb/lifeform): Another gem of mine, this allows most forms to be defined in standalone objects with a straightforward DSL. You can then render those forms by emitting each of the fields which were defined, or you can simply auto-render the entire form with a single statement. Between the syntax affordances of Serbea and Lifeform, that statement looks like this: {% raw %}`{%@ PresetForm @preset %}`{% endraw %}. _No joke!_

* [ViewComponent](https://viewcomponent.org) & [Heartml](https://github.com/heartml/heartml): Created by the fine folks at GitHub, ViewComponent provides an object-oriented view engine for Rails apps. It's much more sophisticated than "partials" and lets you apply OOP principles such as encapsulation and separation-of-concerns to your HTML. In addition to this, I've started using a gem I developed called Heartml which enables custom elements be written in a direct superset of HTML which can then be mounted client-side with a parallel JavaScript library for reactivity and interactivity (_more on that below!_).

* [Signalize](https://github.com/whitefusionhq/signalize): So the original [Signals JS](https://github.com/preactjs/signals) library (created by the fine folks at Preact) has been such a game-changer on the frontend, I decided to port it to Ruby! By having signals & effects in Ruby, I was able to develop a unique pipeline for managing the generation and updates of Zip files containing presets, a readme file, etc. which is seamless for users of Preset Galaxy. I also employ the reverse_markdown gem to convert the HTML output from Trix editor to Markdown for the readme file.

**And now for the frontend**. It should come as no surprise I elected to use [esbuild](https://esbuild.github.io) for our frontend bundling pipeline. I like to think of esbuild as "the last bundler"—it's unlikely I'd ever consider using another build tool any time in the foreseeable future. I also spent a lot of time optimizing our primary CSS & JS bundles and code-splitting wherever possible for the fastest performance and leanest page weight. Some of the libraries used:

* [Ruby2JS](https://www.ruby2js.com): Virtually all the frontend code—and there is a fair bit as part of various view components—is written in the Ruby-like syntax of Ruby2JS. Originally created by Sam Ruby (really, that's his name!) and subsequently maintained by yours truly, using Ruby2JS means I can take advantage of the superior syntax and idioms of Ruby while leveraging all of the goodies available in the modern ESM ecosystem.

* [Shoelace](https://shoelace.style): A tremendous resource for web developers, the Shoelace library of web components provides us with features like icons, toasts, star ratings, tagged autocompletes (a solution I built from atomic Shoelace components), switches, progress bars, and more.

* [Bulma](https://bulma.io): Fun fact…the first prototype of Preset Galaxy was actually built on the Foundation CSS framework (!!). We then ported the site over to Bulma. At this point, while I like Bulma a lot, I'm increasingly putting effort into UI solutions using vanilla CSS and web components for the future of our frontend. Which brings me finally to:

* [Heartml](https://github.com/heartml/heartml): As the frontend corollary to the Ruby renderer, we use Heartml as our web component base class, providing encapsulated UI reactivity and interactivity inside of most of our custom elements across the application. While certain coordination features between the frontend & backend are handled by Turbo over-the-wire, I spent a decent amount of time ensuring many UI updates are "optimistic"—that is, you don't have to wait for the server to "do its thing" before you see the results of a click or a form submission. It's amazing what over-the-wire + surgical use of optimistic UI can do to make a web app seem alive and performant—_without_ having to write a gargantuan frontend in an everything-but-the-kitchen-sink JS framework.

And of course, the [Preset Galaxy Blog](https://blog.presetgalaxy.com) is powered by [Bridgetown](https://www.bridgetownrb.com), a Ruby-based progressive site generator maintained by…yeah, that would be me. 😅

### Testing and Opening to the Public

Once we'd gotten a fair ways down the path of developing an "MVP" (Minimal Viable Product in _startup-parlance_), it was time to run through a private beta test.

We opened a [Discord server](https://discord.gg/Y4vae7BYdA) for beta testers to offer their feedback. This was undoubtedly a valuable part of the development process—but perhaps not in the way you might think. Yes, it was worthwhile to uncover and fix bugs caught during this beta phase, but what was even more welcome was the ability to hear from testers their thoughts about the utility of the service. It helped validate the _raison d'être_ of Preset Galaxy and provide us with renewed focus on the core promise for users.

**Finally**, in early 2024, we released **[Preset Galaxy](https://www.presetgalaxy.com)** to the public! 🎉 🥳

As anyone who's participated in a new software launch can attest to, this is a moment both **exhilarating** and **terrifying**. Thankfully, the effort we'd put in over a lengthy period of time to ensure platform stability, as well as the private beta test, meant that the public launch went off without a hitch—and it's been relatively smooth sailing (🚀 _smooth flying?_ 🤔) ever since.

### Conclusion

I'll reiterate what I said up top: I've been privileged to work with many fine clients over the years at [Whitefusion](https://www.whitefusion.studio), but the list of projects I've been on which provide that fantastic blend of personal interest and technical affinity is short indeed. I'm thankful Greg and **Orange Tree Samples** took a serious bet on this idea, and I'm truly thrilled to see what music producers will publish through [Preset Galaxy](https://www.presetgalaxy.com) in the months ahead.

----

**P.S.** OK, I lied above…allow me to indulge in a _tiny_ bit of shameless self-promotion. I encourage you to head over to **[Whitefusion](https://www.whitefusion.studio)** and check out what we're all about if you have a website or web application project in mind and you need a studio to build it.

_Hailing frequencies are open!_ 📡
