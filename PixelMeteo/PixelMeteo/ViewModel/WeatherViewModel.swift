//
//  WeatherViewModel.swift
//  PixelMeteo
//
//  Created by Janice on 4/11/24.
//

import SwiftUI

class WeatherViewModel {
    private var weather: Weather
    
    func fetchData() {
        weather.fetchData()
    }
    
    init() {
        weather = Weather()
    }
}
