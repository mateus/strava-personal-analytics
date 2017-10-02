module WeatherHelper
  API_OPTIONS = { units: 'metric', APPID: ENV.fetch('OPEN_WEATHER_MAP_KEY') }
  IMAGE_URL = 'https://openweathermap.org/img/w/{icon}.png'

  def current_weather
    {
      temperature: current_temperature,
      image: current_weather_image,
      wind_speed: current_weather_wind_speed,
      wind_deg_formated: current_weather_wind_deg_formated,
      wind_deg: current_weather_wind_deg,
      sunset: current_weather_sunset,
      sunrise: current_weather_sunrise,
    }
  end

  private

  def current_weather_sunset
    Time.at(weather_right_now['sys']['sunset']).in_time_zone(ENV.fetch('TIMEZONE')).strftime('%I:%M%P')
  end

  def current_weather_sunrise
    Time.at(weather_right_now['sys']['sunrise']).in_time_zone(ENV.fetch('TIMEZONE')).strftime('%I:%M%P')
  end

  def current_weather_wind_speed
    "#{weather_right_now['wind']['speed'].round} km/h"
  end

  def current_weather_wind_deg_formated
    return 0 unless !!weather_right_now['wind']['deg']
    "#{weather_right_now['wind']['deg'].round}°"
  end

  def current_weather_wind_deg
    return 0 unless !!weather_right_now['wind']['deg']
    weather_right_now['wind']['deg'].round
  end

  def current_temperature
    weather_right_now["main"]["temp"].round
  end

  def current_weather_image
    IMAGE_URL.gsub('{icon}', weather_right_now['weather'][0]['icon'])
  end

  def weather_right_now
    weather_current ||= OpenWeather::Current.city(ENV.fetch('OPEN_WEATHER_MAP_LOCATION'), API_OPTIONS)
  end
end
