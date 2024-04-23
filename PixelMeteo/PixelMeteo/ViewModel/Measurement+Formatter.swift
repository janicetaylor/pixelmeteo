//
//  Measurement+Formatter.swift
//  PixelMeteo
//
//  Created by Janice on 4/23/24.
//

import Foundation

extension Measurement {
    
    func truncateTemperature(measurement: Measurement<UnitTemperature>, unit:UnitTemperature) -> String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        let converted = measurement.converted(to: unit)
        let output = formatter.string(from: converted)
        return output
    }
    
}
