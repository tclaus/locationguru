# frozen_string_literal: true

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Uncomment this to test error pages
  # config.consider_all_requests_local = false
  # config.exceptions_app = self.routes

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Use a real queuing backend for Active Job (and separate queues per environment)
  config.active_job.queue_adapter     = :resque
  config.active_job.queue_name_prefix = "LocationGuru_#{Rails.env}"

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :mailgun
  config.action_mailer.mailgun_settings = {
    address: ENV['SMTP_SERVER'],
    port: ENV['SMTP_SERVER_PORT'],
    domain: ENV['SMTP_SEND_FROM_DOMAIN'],
    user_name: ENV['SMTP_USERNAME'],
    password: ENV['SMTP_PASSWORD'],
    api_key: ENV['SMTP_API_KEY'],
    authentication: 'plain',
    enable_starttls_auto: true
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  config.action_view.raise_on_missing_translations = false

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.paperclip_defaults = {
    storage: :s3,
    s3_protocol: :https,
    org_path: ':class/:id/:style/:filename',
    path: ':class/:id/:style/:hash.:extension',
    hash_secret: ENV['PAPERCLIP_HASH_SECRET'],
    s3_host_name: 's3.eu-central-1.amazonaws.com',
    s3_credentials: {
      bucket: ENV['s3_bucket_name'],
      access_key_id: ENV['s3_key_id'],
      secret_access_key: ENV['s3_access_key'],
      s3_region: 'eu-central-1'
    }
  }
end
