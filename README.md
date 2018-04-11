# README

This is Location Guru.
A ruby-on-rails platform for handling venues.

Configuration
Upload to heroku
1. $: Heroku login
2. Setup Datenbase on heroku
    heroku run rake db:schema:load
    heroku run rake db:seed

Migrate Database:
On every update dont forget a

  heroku rake db:migrate

to set database to latest state.


Bulk Update Locations:
  rake geocode:all CLASS=Location SLEEP=0.25
