//
//  HourlyWeatherData.swift
//  PixelMeteo
//
//  Created by Janice on 4/17/24.
//

import SwiftUI

struct HourlyWeather: Identifiable {
    var id = UUID()
    var time: String
    var temperature: Double
}
