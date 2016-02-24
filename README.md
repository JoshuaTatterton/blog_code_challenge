#### Challenge Spec

Expectations

This challenge should be fairly straight-forward to complete - it is not designed as a pass-fail test but instead is useful for determining your mindset when it comes to software architecture, data modelling, testing etc.

Please assume you’d be deploying the application to a production environment on completion and work to what you believe to be best practice in that regard.

Your work should be tracked with Git from the start - please publish the full history of commits to a public Git repository upon completion.

Feel free to extend the spec beyond the basic features if you wish to demonstrate any web development skills you might have.

Overview

We’re going to build a simple blog which has commenting and email subscription for notifications of new articles.

Features

Articles should be created, modified and deleted via a UI.
Articles should be accessible via an SEO-friendly URL.
The article body should be written in and rendered with Markdown
Visitors can comment on articles.
Visitors can subscribe to the site with their email address.
Each time an article is posted, asynchronously, subscribers should be sent a notification containing information about the new post and a link to view it.
Each email should contain a link to unsubscribe.

Technologies

We expect to see the latest stable versions of Ruby and Rails, but beyond that use technologies as you see fit, our preferences are:

Testing: Rspec
DB: Postgres
Views: Semantic, clean HTML5 in Erb
Assets: CoffeeScript / SASS

There is no time limit for this challenge, but please be honest when reporting how long you spent working on it.