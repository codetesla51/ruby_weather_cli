require 'httparty'
require 'json'
require 'colorize'
require 'terminal-table'
require 'emoji_regex'

class WeatherCLI
  WEATHER_ICONS = {
    'clear' => '☀️ ',
    'rain' => '🌧️ ',
    'cloud' => '☁️ ',
    'snow' => '❄️ ',
    'thunderstorm' => '⚡',
    'mist' => '🌫️ ',
    'default' => '🌈 '
  }

  def initialize(api_key)
    @api_key = api_key
  end
#program entry point
  def start
    clear_screen
    display_welcome_banner
    main_loop
  end

  private

  def main_loop
    loop do
      city = prompt_for_city
      break if city.downcase == 'exit' || city.downcase == 'q'
      
      display_loading_animation
      fetch_and_display_weather(city)
      puts "\nPress any key to check another city or type 'exit' or 'q' to quit...".light_yellow
      
      gets.chomp
      clear_screen
    end
    display_goodbye_message
  end

  def fetch_and_display_weather(city)
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{@api_key}&units=metric"
    response = HTTParty.get(url)
    weather_data = JSON.parse(response.body)

    if weather_data['cod'] == 200
      display_weather(weather_data)
    else
      display_error_message
    end
  end

  def display_weather(data)
    clear_screen
    display_location_header(data)
    display_weather_table(data)
    display_additional_info(data)
  end

  def display_location_header(data)
    city = data['name']
    country = data['sys']['country']
    puts "\n#{'═' * 60}".light_blue
    puts "#{get_weather_icon(data['weather'][0]['description'])} Weather in #{city}, #{country} #{get_weather_icon(data['weather'][0]['description'])}".center(60).light_cyan.bold
    puts "#{'═' * 60}".light_blue
  end

  def display_weather_table(data)
    rows = []
    rows << ['Temperature', "#{data['main']['temp']}°C"]
    rows << ['Feels Like', "#{data['main']['feels_like']}°C"]
    rows << ['Humidity', "#{data['main']['humidity']}%"]
    rows << ['Wind Speed', "#{data['wind']['speed']} m/s"]
    rows << ['Weather', data['weather'][0]['description'].capitalize]
    rows << ['Pressure', "#{data['main']['pressure']} hPa"]

    table = Terminal::Table.new do |t|
      t.rows = rows
      t.style = { border: :unicode, padding_left: 3, padding_right: 3 }
    end

    puts table.to_s.light_green
  end


def display_additional_info(data)
  sunrise = Time.at(data['sys']['sunrise']).strftime('%H:%M')
  sunset = Time.at(data['sys']['sunset']).strftime('%H:%M')

  thick_line = '━' * 60
  puts "\n#{thick_line.light_blue}" 
  puts "🌅 Sunrise: #{sunrise}  |  🌇 Sunset: #{sunset}".center(60).light_yellow
  puts "📍 Location: #{data['coord']['lat']}°N, #{data['coord']['lon']}°E".center(60).light_yellow
  puts "#{thick_line.light_blue}" 
end

  def get_weather_icon(description)
  description = description.downcase

  case description
  when /clear/
    return WEATHER_ICONS['clear']
  when /rain/
    return WEATHER_ICONS['rain']
  when /cloud/
    return WEATHER_ICONS['cloud']
  when /snow/
    return WEATHER_ICONS['snow']
  when /thunderstorm/
    return WEATHER_ICONS['thunderstorm']
  when /mist/
    return WEATHER_ICONS['mist']
  else
    return WEATHER_ICONS['default']
  end
end


def prompt_for_city
  thick_long_arrow = "====➤".light_green.bold 
  print "\n#{thick_long_arrow} Enter city name (or 'exit' to quit): ".light_green.bold
  gets.chomp
end  


def display_welcome_banner
  puts "\n"
  puts "++----------------------------------++".green
  puts "++----------------------------------++".green
  puts "||██████╗ ██╗   ██╗██████╗ ██╗   ██╗||".green
  puts "||██╔══██╗██║   ██║██╔══██╗╚██╗ ██╔╝||".green
  puts "||██████╔╝██║   ██║██████╔╝ ╚████╔╝ ||".green
  puts "||██╔══██╗██║   ██║██╔══██╗  ╚██╔╝  ||".green
  puts "||██║  ██║╚██████╔╝██████╔╝   ██║   ||".green
  puts "||╚═╝  ╚═╝ ╚═════╝ ╚═════╝    ╚═╝   ||".green
  puts "++----------------------------------++".green
  puts "++----------------------------------++".green
  puts "\n"
end  

  def display_goodbye_message
    puts "\n#{'Thank you for using Weather CLI! Goodbye! 👋'.center(60)}".light_cyan
    puts "\n"
  end

  def display_error_message
    puts "\n❌ City not found or API error! Please try again.".red
  end

  def display_loading_animation
    print "Loading weather data "
    3.times do
      print "."
      sleep 0.2
    end
    print "\r#{' ' * 30}\r"
  end

  def clear_screen
    system('clear') || system('cls')
  end
end
  weather = WeatherCLI.new("YOUR_API_KEY_HERE")
  weather.start
