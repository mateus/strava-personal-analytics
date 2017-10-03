module WeatherHelper
  API_OPTIONS = { units: 'metric', APPID: ENV.fetch('OPEN_WEATHER_MAP_KEY') }
  IMAGE_URL = 'https://openweathermap.org/img/w/{icon}.png'

  def current_weather
    weather ||= OpenWeather::Current.city(ENV.fetch('OPEN_WEATHER_MAP_LOCATION'), API_OPTIONS)

    if weather['cod'] != 200
      @weather_error_message = weather['message']
      return nil
    else
      {
        temperature: current_temperature(weather),
        image: current_weather_image(weather),
        wind_speed: current_weather_wind_speed(weather),
        wind_deg_formated: current_weather_wind_deg_formated(weather),
        wind_deg: current_weather_wind_deg(weather),
        sunset: current_weather_sunset(weather),
        sunrise: current_weather_sunrise(weather),
      }
    end
  end

  private

  def current_weather_sunset(weather)
    Time.at(weather['sys']['sunset']).in_time_zone(ENV.fetch('TIMEZONE')).strftime('%I:%M%P')
  end

  def current_weather_sunrise(weather)
    Time.at(weather['sys']['sunrise']).in_time_zone(ENV.fetch('TIMEZONE')).strftime('%I:%M%P')
  end

  def current_weather_wind_speed(weather)
    "#{weather['wind']['speed'].round} km/h"
  end

  def current_weather_wind_deg_formated(weather)
    return '0°' unless !!weather['wind']['deg']
    "#{weather['wind']['deg'].round}°"
  end

  def current_weather_wind_deg(weather)
    return 0 unless !!weather['wind']['deg']
    weather['wind']['deg'].round
  end

  def current_temperature(weather)
    weather['main']['temp'].round
  end

  def current_weather_image(weather)
    IMAGE_URL.gsub('{icon}', weather['weather'][0]['icon'])
  end
end
