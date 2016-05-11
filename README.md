## This is a Blogger Website code challenge

I had to complete this code challenge for an interview process, and the original specification for the challenge [can be found here](https://github.com/JoshuaTatterton/blog_code_challenge/blob/master/challenge_spec.md) but once I started as an exercise I was asked to add new features and give the (terrible) front end an overhaul. So after two painful front end overhauls the project has been satisfactorily completed and can be found on [heroku here](https://banana-pudding-29266.herokuapp.com)

The general features are as follows: 

```
A User can sign up to be a Blogger.
A Blogger can write Blog Posts.
Blog Posts can be written and rendered in Markdown and in a WYSIWYG editor (ckeditor).
Blog Posts can be edited/deleted after initial creation.
Visiters can Subscribe to receive Emails when a Blogger Posts a new Article.
Subscribers can Unsubscribe from a link shown in these Email.
Searches can be performed to find specific Blog Posts.
```

#### Skills Used

- The majority of skills used were things that I have used before on previous rails projects such as work with rails, heroku, html, rspec, capybara. So this was a good exercise in these skills.
- This is by far the best looking website I have built (as of May 2016) and this was a big undertaking of CSS and SCSS and applying ITCSS and BEM principles to the process.
- I initially used jQuery for handling processes on the front end but this was later refactored out to be completed with CSS check box switches.

#### Skills Gained/ Improved

- As Stated above the CSS put into the front end was intensive and I spent a lot of time trying to get the designing aspect of web development down. This can be seen in the designs folder where all wireframes and mockups have been stored. Also there was a lot of time spent researching typography, colour theory, UX design and aestetic principles.
- Another reason the CSS too so long was the implementation of responsive design using media queries (a first for me) at various screen sizes.
- The implementation of sending emails was a new process for me as any that had been sent from other projects were built into gems, so this was the first time I had implemented them myself with Rails Mailer.
- During the project it was recomended that the sending of emails be handled by a worker so Sidekiq was introduced as a worker. This lead to many problems with Redis and heroku's implementation of workers in it dyno system. In an attempt to work around these issues Puma was introduced to house both workers and website.
- Using Sorcery was also a new experience as it is a lot more stripped down than device which I have used previously. This gave me more freedom in the design and control of the usermanagement.

#### Technologies Used

- Production: Ruby on Rails, Heroku, [Sorcery](https://github.com/NoamB/sorcery), [Sidekiq](https://github.com/mperham/sidekiq), Redis, Postgresql, [Puma](https://github.com/puma/puma), [Redcarpet](https://github.com/vmg/redcarpet), [ckeditor](https://github.com/galetahub/ckeditor), JQuery
- Testing: RSPEC, Capybara, Database Cleaner, Selenium Webdiver