//
//  Double+Formatter.swift
//  PixelMeteo
//
//  Created by Janice on 4/23/24.
//

import Foundation

extension Double {
    
    func truncateTemperature(measurement: Measurement<UnitTemperature>) -> String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        let output = formatter.string(from: measurement)
        return output
    }
    
}
