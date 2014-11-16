滕州一中校友会 - tzyz
===
This is the project of the official site of Alumni Association of Tengzhou No.1 High School, based on [Ruby on Rails](http://rubyonrails.org/).

# Get started
1. Initilize database: `rake db:migrate:reset && rake db:setup` (or `bundle exec rake db:migrate:reset && rake db:setup`)
2. We are using [redis](http://redis.io/) for cache, session and sidekiq. Please install [redis](http://redis.io/) and setup the configuration of redis in file( `config/secrets.yml` )
3. Run sidekiq: `bundle exec sidekiq -C config/sidekiq.yml` (and you could view
`http://localhost:3000/sidekiq/queues` to view the monitor)

# Naming conventions
- Node Categories: use plural for countable nouns, eg. schools, interests
- Node: use singular for countable nouns, eg. doctor, programmer

# TODO
You could find all the TODOs right here: [https://github.com/imWildCat/tzyz/labels/enhancement](https://github.com/imWildCat/tzyz/labels/enhancement) (Issues labelled enhancement).

# Join us
You are supposed to use English everywhere in this project except Chinese words in the views.
Before starting, please contact [@imWildCat](https://github.com/imWildCat) for more details.

# LICENSE
The MIT License.