滕州一中校友会 - tzyz
===
This is the project of the official site of Alumni Association of Tengzhou No.1 High School, based on [Ruby on Rails](http://rubyonrails.org/).

# Get started
1. Initilize database: `rake db:migrate:reset && rake db:setup` (or `bundle exec rake db:migrate:reset && rake db:setup`)
2. Start sidekiq: `bundle exec sidekiq -C config/sidekiq.yml` (And you could view
`http://localhost:3000/sidekiq/queues` to view the monitor)

# TODO
You could find all the TODOs right here: https://github.com/imWildCat/tzyz/issues?labels=enhancement&page=1&state=open (Issues labelled enhancement).

# Join us
You are supposed to use English everywhere in this project except Chinese words in the views.
Before starting, please contact [@imWildCat](https://github.com/imWildCat) for more details.

# LICENSE
The MIT License.