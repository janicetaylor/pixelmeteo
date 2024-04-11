//
//  WeatherModel.swift
//  PixelMeteo
//
//  Created by Janice on 4/11/24.
//

import Foundation

struct Weather {
    
    init() {
        // initialize all variables 
    }
    
    enum WeatherDataError: Error {
        case invalidURL
    }
    
    func fetchData() async throws -> WeatherData {
        let endpoint = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,rain,showers,snowfall,weather_code&hourly=temperature_2m&daily=weather_code,sunrise,sunset,precipitation_sum,rain_sum,showers_sum,precipitation_probability_max&temperature_unit=fahrenheit&timezone=America%2FChicago"
        guard let url = URL(string: endpoint) else { fatalError("endpoint: \(endpoint) not valid") }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw WeatherDataError.invalidURL
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherData.self, from: data)
        } catch {
            fatalError("unable to decode url")
        }
    }
    
  
    
}


