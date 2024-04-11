//
//  WeatherModel.swift
//  PixelMeteo
//
//  Created by Janice on 4/11/24.
//

import Foundation

struct Weather {
    // https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,rain,showers,snowfall,weather_code&hourly=temperature_2m&daily=weather_code,sunrise,sunset,precipitation_sum,rain_sum,showers_sum,precipitation_probability_max&temperature_unit=fahrenheit&timezone=America%2FChicago
    
    init() {
        // initialize all variables 
    }
    
    func fetchData() {
        // get json from feed
    }
    
    struct WeatherData {
        var longtitude: Double
        var latitude: Double
    }
    
}


