//
//  WeatherViewModel.swift
//  PixelMeteo
//
//  Created by Janice on 4/11/24.
//

import SwiftUI

class WeatherViewModel {
    
    private var weather: Weather
    
    init() {
        weather = Weather()
    }
    
     func fetchData() async {
        do {
            let weatherData: WeatherData = try await weather.fetchData()
            print(weatherData as WeatherData)
        } catch {
            fatalError("invalid url")
        }
    }
}
