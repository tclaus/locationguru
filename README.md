# README

This is Location Guru.
A ruby-on-rails platform for handling venues.

Local installation
------------------
Install Postgres Database
  (Set environment var?)
$: bundle install

On OSX install redis-server
Its needed for Jobs as well as for caching
$: brew install redis

You might want to start redis before running local


Start / Update in Productive-Configuration
------------------------------------------
Upload to heroku
1. $: Heroku login
2. Setup Datenbase on heroku
    heroku run rake db:schema:load
    heroku run rake db:seed

Migrate Database:
On every update don't forget a

$: heroku rake db:migrate

to set database to latest state.


Bulk Update Locations:
  rake geocode:all CLASS=Location SLEEP=0.25
