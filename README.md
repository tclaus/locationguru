# README

This is Location Guru.
A ruby-on-rails platform for handling venues.

Local installation
------------------
Install Postgres Database
 * Use Postgress App from Postges Server: https://postgresapp.com
 
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
You now have Ruby, Railsm Gemfiles, and redis server. 
Databases are created. 
Just seed development Database with initial data: 

$: rails db:seed

To get a full list of tasks available in Rails and what db tasks you have simply ask rails: 

$: rails --tasks

Start the server: 

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


Start / Update in Productive-Configuration
------------------------------------------
Upload to heroku
1. $: Heroku login
2. Setup Database on heroku
    heroku run rake db:schema:load -a locationguru-dev
    heroku run rake db:seed -a locationguru-dev

Migrate Database:
On every update don't forget a

Development:
  heroku run rake db:migrate -a locationguru-dev

Production:
  heroku run rake db:migrate -a locationguru

to set database to latest state.


Bulk Update Locations:
  rake geocode:all CLASS=Location SLEEP=0.25
