//
//  WeatherData.swift
//  PixelMeteo
//
//  Created by Janice on 4/11/24.
//

struct CurrentUnits: Codable {
    let time: String
    let interval: String
    let temperature_2m: String
    let relative_humidity_2m: String
    let apparent_temperature: String
    let is_day: String
    let precipitation: String
    let rain: String
    let showers: String
    let snowfall: String
    let weather_code: String
}

struct Current: Codable {
    let time: String
    let interval: Int
    let temperature_2m: Double
    let relative_humidity_2m: Int
    let apparent_temperature: Double
    let is_day: Int
    let precipitation: Int
    let rain: Int
    let showers: Int
    let snowfall: Int
    let weather_code: Int
}

struct HourlyUnits: Codable {
    let time: String
    let temperature_2m: String
}

struct Hourly: Codable {
    let time: [String]
    let temperature_2m: [Double]
}

struct DailyUnits: Codable {
    let time: String
    let weather_code: String
    let sunrise: String
    let sunset: String
    let precipitation_sum: String
    let rain_sum: String
    let showers_sum: String
    let precipitation_probability_max: String
}

struct Daily: Codable {
    let time: [String]
    let weather_code: [Int]
    let sunrise: [String]
    let sunset: [String]
    let precipitation_sum: [Double]
    let rain_sum: [Double]
    let showers_sum: [Double]
    let precipitation_probability_max: [Int]
}

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let generationtime_ms: Double
    let utc_offset_seconds: Int
    let timezone: String
    let timezone_abbreviation: String
    let elevation: Int
    let current_units: CurrentUnits
    let current: Current
    let hourly_units: HourlyUnits
    let hourly: Hourly
    let daily_units: DailyUnits
    let daily: Daily
}
