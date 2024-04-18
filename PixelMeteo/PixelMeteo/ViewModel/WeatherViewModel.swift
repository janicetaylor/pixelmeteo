//
//  WeatherViewModel.swift
//  PixelMeteo
//
//  Created by Janice on 4/11/24.
//

import SwiftUI

@MainActor class WeatherViewModel: ObservableObject {
    
    private var weather: Weather = Weather()
    
    @Published var currentTemperature = 0
    @Published var currentTemperatureHigh = 0
    @Published var currentTemperatureLow = 0
    @Published var rain = 0
    @Published var snowfall = 0
    @Published var apparentTemperature = 0
    @Published var sunset = [String]()
    @Published var sunrise = [String]()
    @Published var todaySunset = "0:00"
    @Published var todaySunrise = "0:00"
    
    var dailyChanceofRain = [String]()
    var dailyTime = [String]()
    var dailyTempHigh = [String]()
    var dailyTempLow = [String]()
    
    @Published var hourlyWeathers = [HourlyWeather]()
    @Published var dailyWeathers = [DailyWeather]()
    
    init() { }

    func fetchData() async {
        do {
            let weatherData = try await weather.fetchData()
          //  print(weatherData as WeatherData)
            currentTemperature = Int(weatherData.current.temperature_2m)
            rain = Int(weatherData.current.rain)
            snowfall = Int(weatherData.current.snowfall)
            apparentTemperature = Int(weatherData.current.apparent_temperature)
            sunset = weatherData.daily.sunset
            sunrise = weatherData.daily.sunrise
            todaySunset = sunset.first ?? "0:00"
            todaySunrise = sunrise.first ?? "0:00"
            
            var hourlyTemperature = weatherData.hourly.temperature_2m
            hourlyTemperature.enumerated().forEach { (index, value) in
                let hourlyWeather = HourlyWeather(time: weatherData.hourly.time[index], temperature: weatherData.hourly.temperature_2m[index])
                hourlyWeathers.append(hourlyWeather)
            }
            
            let dailyTemperature = weatherData.daily.time
            dailyTemperature.enumerated().forEach { (index, value) in
                let dailyWeather = DailyWeather(time: weatherData.daily.time[index], weather_code: weatherData.daily.weather_code[index], sunrise: weatherData.daily.sunrise[index], sunset: weatherData.daily.sunset[index], precipitation_sum: weatherData.daily.precipitation_sum[index], rain_sum: weatherData.daily.rain_sum[index], showers_sum: weatherData.daily.showers_sum[index], precipitation_probability_max: weatherData.daily.precipitation_probability_max[index])
                dailyWeathers.append(dailyWeather)
            }
            
        } catch {
            fatalError("invalid url")
        }
    }
    
    func shortWeatherDescription(for code: Int) -> String {
        let weatherCodes: [Int: String] = [
           0: "Clear",
           1: "Clear",
           2: "Cloudy",
           3: "Overcast",
           45: "Fog",
           48: "Foggy",
           51: "Drizzle",
           52: "Drizzle",
           53: "Drizzle",
           56: "Freezing",
           57: "Freezing",
           61: "Rain",
           62: "Rain",
           63: "Rain",
           66: "Freezing",
           67: "Freezing",
           71: "Snow",
           72: "Snow",
           73: "Snow",
           77: "Snow",
           80: "Showers",
           81: "Showers",
           82: "Showers",
           85: "Showers",
           86: "Showers",
           95: "Thunderstorm",
           96: "Thunderstorm",
           99: "Thunderstorm"
        ]
        
        guard let weatherCode = weatherCodes[code] else {
            print("weather code not found")
            return ""
        }
        return weatherCode
    }
    
    func getImageNameForWeatherCode(code: Int) -> String {
        switch code {
        case 0, 1:
            return "wc-clear"
        case 2, 3, 45, 48:
            return "wc-cloud"
        case 51...67:
            return "wc-rain"
        case 71...77:
            return "wc-snow"
        case 80...86:
            return "wc-storm"
        default:
            return "wc-clear"
        }
    }
 
}
