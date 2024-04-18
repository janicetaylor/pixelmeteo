//
//  DailyWeather.swift
//  PixelMeteo
//
//  Created by Janice on 4/17/24.
//

import Foundation

struct DailyWeather: Identifiable {
    var id = UUID()
    var time: String
    var weather_code: Int
    var sunrise: String
    var sunset: String
    var precipitation_sum: Double
    var rain_sum: Double
    var showers_sum: Double
    var precipitation_probability_max: Int
}
