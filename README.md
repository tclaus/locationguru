# README

This is Location Guru.
A ruby-on-rails platform for handling venues.

Production Site can be visited under: [locationguru.net](https://locationguru.net) or
[venueguru.net](https://venueguru.net)

Local installation
------------------
Install Postgres Database
Use Postgres App from Postgres Server: [postgresapp.com](https://postgresapp.com)

You need to create local test and development databases:

$:rails db:setup

Install GEM Files
-----------------
$: bundle install

Install jobs / scheduler
------------------------
On OSX install redis-server
Its needed for Jobs as well as for caching

$: brew install redis

You might want to start redis before running local

Start development environment
-----------------------------
You now have Ruby, Rails Gemfiles, and redis server.
Databases are created.
Just seed development Database with initial data:

$: rails db:seed

To get a full list of tasks available in Rails and what db tasks you have simply ask rails:

$: rails --tasks

Start the server
------------------
1. start the redis-server
2. start a batch job queue
3. start rails server

$: resdis-server
$: QUEUE=* rake environment resque:work

$: rails s

    => Booting Puma

    => Rails 5.2.0 application starting in development

    => Run `rails server -h` for more startup options

    Puma starting in single mode...

    * Version 3.11.4 (ruby 2.5.1-p57), codename: Love Song

    * Min threads: 5, max threads: 5

    * Environment: development

    * Listening on tcp://0.0.0.0:3000

    Use Ctrl-C to stop

Open your browser at: http://localhost:3000

Write tests and running
$: rails test

Start / Update in Productive-Configuration
------------------------------------------
Upload to heroku
1. $: Heroku login
2. Setup Database on heroku
    heroku run rake db:schema:load -a <app name>
    heroku run rake db:seed -a <app name>

Migrate Database:
On every update don't forget a

Development:
  heroku run rake db:migrate -a <app name>

to set database to latest state.

In Procfile there is a line 'release: bundle exec rake db:migrate' that should do the DB:Migration task automatically on deployment.

Bulk Update Locations:
  rake geocode:all CLASS=Location SLEEP=0.25
