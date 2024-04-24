//
//  HourlyInfo.swift
//  PixelMeteo
//
//  Created by Janice on 4/23/24.
//

import Foundation

struct WeatherInfo: Identifiable {
    var id = UUID()
    var temperature: String 
    var time: Date
    var formattedTime: String // 8pm
    var formattedDay: String // Mon 
    var description: String 
}
