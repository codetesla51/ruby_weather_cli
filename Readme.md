# WeatherCLI 🌦️

WeatherCLI is a command-line Ruby application that allows users to fetch weather information for any city in the world. It fetches data from the [OpenWeatherMap API](https://openweathermap.org/api) and displays weather details such as temperature, humidity, wind speed, sunrise, sunset, and more. The app features a modern, colorful interface with weather icons and smooth animations to enhance the user experience.

## ✨ Features

- Real-time weather data for any city worldwide
- Comprehensive weather information including:
  - Temperature (°C and °F)
  - Humidity and pressure
  - Wind speed (m/s and mph)
  - Visibility
  - Sunrise and sunset times
  - Day length
- Smart weather recommendations based on conditions
- Search history tracking
- Data caching for improved performance
- Beautiful CLI interface with colors and animations
- Error handling with automatic retries
- Responsive loading animations
- Weather condition-specific icons

## 📋 Prerequisites

Before running this project, ensure you have:

- Ruby (version 2.0 or higher)
- The following Ruby gems:
  - `httparty` (for API requests)
  - `terminal-table` (for formatted output)
  - `colorize` (for terminal colors)
  - `emoji_regex` (for emoji support)

Install the required gems using:

```bash
gem install httparty terminal-table colorize emoji_regex
```

## 🚀 Installation

1. Clone the repository:
```bash
https://github.com/codetesla51/ruby_weather_cli
cd ruby_weather_cli
```

2. Set up your API key:
   - Sign up for a free API key at [OpenWeatherMap](https://openweathermap.org/api)
   - replace `YOUR_API_KEY_HERE` in the script with your key

3. Run the application:
```bash
ruby weather_cli.rb
```

## 💻 Usage

When you start WeatherCLI, you'll see a welcome banner and menu with the following options:

- Enter a city name to check weather
- Type 'history' or 'h' to view search history
- Type 'exit' or 'q' to quit
