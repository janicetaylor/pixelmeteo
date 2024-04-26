//
//  DailyWeatherInfo.swift
//  PixelMeteo
//
//  Created by Janice on 4/26/24.
//

import Foundation

struct DailyWeatherInfo: Identifiable {
    var id = UUID()
    var tempRange: String 
    var day: String
    var description: String 
}
