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
    @Published var rain = 0
    @Published var snowfall = 0
    @Published var apparentTemperature = 0
    @Published var sunset = [String]()
    @Published var sunrise = [String]()
    @Published var todaySunset = "0:00"
    @Published var todaySunrise = "0:00"
    
    init() { }

    func fetchData() async {
        do {
            let weatherData = try await weather.fetchData()
            print(weatherData as WeatherData)
            currentTemperature = Int(weatherData.current.temperature_2m)
            rain = Int(weatherData.current.rain)
            snowfall = Int(weatherData.current.snowfall)
            apparentTemperature = Int(weatherData.current.apparent_temperature)
            sunset = weatherData.daily.sunset
            sunrise = weatherData.daily.sunrise
            todaySunset = sunset.first ?? "0:00"
            todaySunrise = sunrise.first ?? "0:00"
            
        } catch {
            fatalError("invalid url")
        }
    }
}
