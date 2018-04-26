class DashboardController < ApplicationController
  include DashboardHelper
  include WeatherHelper

  def index
    client = Strava::Api::V3::Client.new(:access_token => ENV.fetch('STRAVA_ACCESS_TOKEN'))
    @athlete = client.retrieve_current_athlete.with_indifferent_access
    @activities = client.list_athlete_activities.reverse
    @weather_location = ENV.fetch('OPEN_WEATHER_MAP_LOCATION').split(',')[0]
  end
end
