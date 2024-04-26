//
//  Date+Formatter.swift
//  PixelMeteo
//
//  Created by Janice on 4/23/24.
//

import Foundation

extension Date {
    func truncateToHour(dateToFormat: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        formatter.timeZone = TimeZone.current
        let formatted = formatter.string(from: dateToFormat)
        return formatted
    }
    
    func truncateToDay(dateToFormat: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        formatter.timeZone = TimeZone.current
        let formatted = formatter.string(from: dateToFormat)
        return formatted
    }
    
    
}


