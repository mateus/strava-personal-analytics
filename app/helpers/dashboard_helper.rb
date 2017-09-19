module DashboardHelper
  def total_distance_all_time(activities)
    distance = list_of(activities)[:distance].sum
    number_to_human(distance, units: :distance, precision: 4)
  end

  def first_activity_date(activities)
    first_activity = activities.last.with_indifferent_access
    first_activity[:start_date].to_time.strftime('%B %e, %Y')
  end

  def list_of(activities)
    {
      distance: activities.map {|a| a['distance']},
      average_speed: activities.map {|a| a['average_speed'] * 3.6},
      max_speed: activities.map {|a| a['max_speed']},
      moving_time: activities.map {|a| a['moving_time']},
      resting_time: activities.map {|a| a['elapsed_time'] - a['moving_time']},
      elapsed_time: activities.map {|a| a['elapsed_time']},
      total_elevation_gain: activities.map {|a| a['total_elevation_gain']},
      start_date_local: activities.map {|a| a['start_date_local'].to_time.strftime('%b %e')}
    }
  end

  def created_at_formated(athlete)
    athlete['created_at'].to_time.strftime('%b %e, %Y')
  end

  def meters_formated(meters)
    number_to_human(meters, units: :distance, precision: 4)
  end

  def seconds_formated(seconds)
    Time.at(seconds).strftime("%H:%M")
  end

  def humanize_seconds(secs)
    [[60, :seconds], [60, :minutes], [24, :hours], [1000, :days]].map{ |count, name|
      if secs > 0
        secs, n = secs.divmod(count)
        "#{n.to_i} #{name}"
      end
    }.compact.reverse.join(' ')
  end

  def meters_per_minute_formated(meters_per_minute)
    "#{(meters_per_minute * 3.6).round(2)} km/h"
  end

  def date_formated(date, in_time_zone)
    in_time_zone = in_time_zone.split(' ')[1]
    date = date.in_time_zone(in_time_zone).strftime('%B %e, %Y at %H:%M%P')
    "#{date} — #{humanize_date(date)}"
  end

  def humanize_date(date)
    "#{distance_of_time_in_words(date, Time.zone.now)} ago"
  end

  def summary_map_url(summary_polyline)
    maps_api_key = ENV.fetch('MAPS_API_KEY')
    "https://maps.googleapis.com/maps/api/staticmap?size=350x350&scale=2&path=weight:3%7Ccolor:red%7Cenc:#{summary_polyline}&sensor=true&key=#{maps_api_key}"
  end
end
