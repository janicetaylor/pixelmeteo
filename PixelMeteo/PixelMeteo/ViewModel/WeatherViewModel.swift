//
//  LocationManager.swift
//  PixelMeteo
//
//  Created by Janice on 4/18/24.
//

import Foundation
import CoreLocation
import CoreLocationUI
import WeatherKit

class WeatherViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var weather: Weather?
    @Published var currentTemperature: String = ""
    @Published var dailyWeatherInfo:[DailyWeatherInfo] = []
    @Published var feelsLikeTemperature: String = ""
    @Published var high: String = ""
    @Published var low: String = ""
    @Published var humidity: Int = 0
    @Published var chanceOfRain: Int = 0
    @Published var precipitationDescription: String = ""
    @Published var snowfallAmount: String = ""
    @Published var sunrise: String = ""
    @Published var sunset: String = ""
    @Published var weeklyInfo:[WeatherInfo] = []
    @Published var hourlyInfo:[WeatherInfo] = []
    @Published var weatherDescription: String = ""
    @Published var symbolName: String = ""
        
    override init() {
        super.init()
    }
    
    func requestLocation() {
    }
    
    func checkCustomFonts() {
        for family in UIFont.familyNames {
        print(family)
            for names in UIFont.fontNames(forFamilyName:family) {
                print("== \(names)")
            }
        }
    }
    
    @MainActor
    func getCurrentWeather(location: CLLocation) async {
        do {
           // let location = CLLocation(latitude: 29.93383411, longitude: -90.08174409)
            weather = try await WeatherService.shared.weather(for: location)
            print(location)
            if let weather = weather {
                updateWeatherValues(weather: weather)
                weatherDescription = weather.currentWeather.condition.description
                symbolName = weather.currentWeather.symbolName
            }
        } catch {
            fatalError("can't get current weather")
        }
    }
        
    @MainActor 
    func getDailyWeather() async {
        do {
            let location = CLLocation(latitude: 29.93383411, longitude: -90.08174409)
            let dailyForecast = try await WeatherService.shared.weather(for: location, including: .daily)
            for daily in dailyForecast {
                let dailyLow = daily.lowTemperature.truncateTemperature(measurement: daily.lowTemperature, unit: .fahrenheit)
                let dailyHigh = daily.highTemperature.truncateTemperature(measurement: daily.highTemperature, unit: .fahrenheit)
                let dailyDate = daily.date.truncateToDay(dateToFormat: daily.date)
                let info: DailyWeatherInfo = DailyWeatherInfo(tempRange: "\(dailyLow)-\(dailyHigh)", day: dailyDate, description: daily.condition.description)
                dailyWeatherInfo.append(info)
            }
        } catch {
            fatalError("can't get weekly weather")
        }
    }
    
    func updateWeatherValues(weather: Weather) {
        let temp = weather.currentWeather.temperature
        currentTemperature = temp.truncateTemperature(measurement: temp, unit: .fahrenheit)
    
        let apparentTemp = weather.currentWeather.apparentTemperature
        feelsLikeTemperature = apparentTemp.truncateTemperature(measurement: apparentTemp, unit: .fahrenheit)
        humidity = Int(weather.currentWeather.humidity*100)
        
        if let dailyForecast = weather.dailyForecast.first {
            let highTemp = dailyForecast.highTemperature
            high = highTemp.truncateTemperature(measurement: highTemp, unit: .fahrenheit)
            
            let lowTemp = dailyForecast.lowTemperature
            low = lowTemp.truncateTemperature(measurement: lowTemp, unit: .fahrenheit)
            
            chanceOfRain = Int(dailyForecast.precipitationChance)
            precipitationDescription = dailyForecast.precipitation.description
            snowfallAmount = dailyForecast.snowfallAmount.formatted()
            
        } else {
            fatalError("can't get daily forecast")
        }
        
        if let sunEvents = weather.dailyForecast.first?.sun {
            sunrise = sunEvents.sunrise?.formatted(date: .omitted, time: .shortened) ?? ""
            sunset = sunEvents.sunset?.formatted(date: .omitted, time: .shortened) ?? ""
        } else {
            fatalError("can't get daily sun events")
        }
        
    }
    
}
