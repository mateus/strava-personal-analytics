require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StravaPersonalAnalytics
  class Application < Rails::Application
    config.exceptions_app = self.routes
    config.load_defaults 5.1
    config.beginning_of_week = :sunday
    config.time_zone = ENV.fetch('TIMEZONE')
    config.active_record.default_timezone = :local
  end
end
