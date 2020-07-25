# README

This is Location Guru.
A ruby-on-rails platform for handling venues.

Production Site can be visited under: [locationguru.net](https://locationguru.net) or
[venueguru.net](https://venueguru.net)

Local installation
------------------
If you still have not develop in Ruby on Rails - install Ruby and Rails first:
On macOS the best way is to use  [RVM](https://rvm.io):
Install RVM with default Ruby and Rails in one Command:
```sh
$: curl -sSL https://get.rvm.io | bash -s stable --rails
```
You may experience errors on install ('binary not found'). In this case open a new
Terminal so make the newly installed RVM active and install ruby with:
```sh
$: rvm install
```
Install Postgres Database
Use Postgres App from Postgres Server: [postgresapp.com](https://postgresapp.com)
Init Database and start Server

Install redis caching service and jobqueue
---------------
You need Redis to send deferred emails
Use Homebrew to install:
```sh
$: brew install redis
```
Start the service
```sh
$: brew services start redis
```
Start the JobQueue:
```sh
$: QUEUE=* rake resque:work
```
Export the redis local environment:
$: export REDISTOGO_URL=localhost:6379

All environments may be inserted to the .env file.

For the environment you can create a .env file in the main directory and copy the
line: 'export REDISTOGO_URL=localhost:6379' into it.

Install ImageMagick
-------
You need this for any image processing and upload
```sh
$: brew install imagemagick
```

Database Setup
--------------
You need to create local test and development databases:
```sh
$:rails db:setup
```
Install GEM Files
-----------------
```sh
$: bundle install
```
You may have problems with the 'pg' gem. in this case try manually this:
```sh
$: gem install 'pg' -- --with_pg_config=/Applications/Postgres.app/Contents/Versions/latest/bin/pg_config
```

Start development environment
-----------------------------
You now have Ruby, Rails Gemfiles, and Redis server.
Databases are created.
Just seed development Database with initial data:
```sh
$: rails db:seed
```
To get a full list of tasks available in Rails and what db tasks you have simply ask rails:
```sh
$: rails --tasks
```
Start the server
------------------
1. Start the redis-server
2. Start a batch job queue
3. Start rails server

$: redis-server
$: QUEUE=* rake environment resque:work

Start locally
-------------
```sh
$: rails s
    => Booting Puma
    => Rails 5.2.x application starting in development
    => Run `rails server -h` for more startup options
    Puma starting in single mode...
    * Version 3.11.4, codename: Love Song
    * Min threads: 5, max threads: 5
    * Environment: development
    * Listening on tcp://0.0.0.0:3000
    * Listening on tcp://[::1]:3000
    Use Ctrl-C to stop
```

Open your browser at: http://localhost:3000

Write tests
-----------
```sh
$: rails test
```

Bulk Update Locations:
  $: rake geocode:all CLASS=Location SLEEP=0.25
