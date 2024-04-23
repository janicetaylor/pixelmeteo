//
//  HourlyInfo.swift
//  PixelMeteo
//
//  Created by Janice on 4/23/24.
//

import Foundation

struct HourlyInfo: Identifiable {
    var id = UUID()
    var temperature: String 
    var time: String
}
