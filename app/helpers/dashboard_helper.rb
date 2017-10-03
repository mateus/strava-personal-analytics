module DashboardHelper
  include FormatterHelper

  def total_distance_all_time(activities)
    distance = list_of(activities)[:distance].sum
    meters_formated(distance)
  end

  def list_of(activities)
    lists ||= {
      distance: activities.map {|a| a['distance']},
      average_speed: activities.map {|a| a['average_speed']},
      max_speed: activities.map {|a| a['max_speed']},
      moving_time: activities.map {|a| a['moving_time']},
      resting_time: activities.map {|a| a['elapsed_time'] - a['moving_time']},
      elapsed_time: activities.map {|a| a['elapsed_time']},
      start_date_local: activities.map {|a| a['start_date_local'].to_time.strftime('%b %e')}
    }
  end

  def this_week_distance(activities)
    filtered = activities.select { |activity| activity['start_date_local'].to_date >= Date.today.beginning_of_week }
    total_distance = filtered.map { |a| a['distance'] }.sum
    meters_formated(total_distance)
  end

  def this_week_time(activities)
    filtered = activities.select { |activity| activity['start_date_local'].to_date >= Date.today.beginning_of_week }
    total_elapsed_time = filtered.map { |a| a['elapsed_time'] }.sum
    seconds_formated(total_elapsed_time)
  end

  def last_week_distance(activities)
    filtered = activities.select {
      |activity| activity['start_date_local'].to_date.between?(Date.today.last_week, Date.today.beginning_of_week - 1.day)
    }
    total_distance = filtered.map { |a| a['distance'] }.sum
    meters_formated(total_distance)
  end

  def last_week_time(activities)
    filtered = activities.select {
      |activity| activity['start_date_local'].to_date.between?(Date.today.last_week, Date.today.beginning_of_week - 1.day)
    }
    total_elapsed_time = filtered.map { |a| a['elapsed_time'] }.sum
    seconds_formated(total_elapsed_time)
  end

  def summary_map_url(summary_polyline)
    maps_api_key = ENV.fetch('MAPS_API_KEY')
    "https://maps.googleapis.com/maps/api/staticmap?size=350x350&scale=2&path=weight:3%7Ccolor:red%7Cenc:#{summary_polyline}&sensor=true&key=#{maps_api_key}"
  end

  def top_speed(activities)
    meters_per_minute_formated(list_of(activities)[:max_speed].max)
  end

  # from last 3 activities
  def current_avg_speed(activities)
    average_speed_arr = list_of(activities)[:average_speed][-3..-1]
    average = average_speed_arr.inject{ |sum, el| sum + el }.to_f / average_speed_arr.size
    meters_per_minute_formated(average)
  end

  def page_description(activities)
    activity = activities.last
    distance = meters_formated(activity['distance'])
    elapsed_time = humanize_seconds(activity['elapsed_time'])
    moving_time = humanize_seconds(activity['moving_time'])
    average_speed = meters_per_minute_formated(activity['average_speed'])
    "Last activity: #{distance} in #{elapsed_time} (#{moving_time} moving) at #{average_speed} average speed."
  end
end
