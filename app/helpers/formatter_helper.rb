module FormatterHelper
  def meters_formated(meters)
    number_to_human(meters, units: :distance, precision: 4)
  end

  def seconds_formated(seconds)
    [seconds / 3600, seconds / 60 % 60, seconds % 60].map { |t| t.to_s.rjust(2,'0') }.join(':')
  end

  def humanize_seconds(secs)
    [[60, 'seconds'], [60, 'minutes'], [24, 'hours'], [1000, 'days']].map{ |count, name|
      if secs > 0
        secs, n = secs.divmod(count)
        if n.to_i == 1
          "#{n.to_i} #{name.singularize}"
        elsif n.to_i > 0
          "#{n.to_i} #{name}"
        end
      end
    }.drop(1).compact.reverse.join(' ')
  end

  def meters_per_minute_formated(meters_per_minute)
    "#{(meters_per_minute * 3.6).round(2)} km/h"
  end

  def date_formated(date, time_zone)
    time_zone = time_zone.split(' ')[1]
    date_formated = date.in_time_zone(time_zone).strftime('%B %e, %Y at %H:%M%P')
    "#{date_formated} — #{humanize_date(date)}"
  end

  def humanize_date(date)
    "#{distance_of_time_in_words(date, Time.zone.now)} ago"
  end
end
