//
//  Font+Style.swift
//  PixelMeteo
//
//  Created by Janice on 4/11/24.
//

import Foundation
import SwiftUI

extension Font {
    
    // PixelLCD-7
    // Silkscreen-Regular
    // Silkscreen-Bold
    // Consolas
    // Pixeled
    
    static let mainTemperature:Font = Font.custom("Pixeled", size: 180.0)
    
    static let headlineSmall:Font = Font.custom("Silkscreen-Regular", size: 12.0)
    static let headlineMedium:Font = Font.custom("Silkscreen-Regular", size: 14.0)
    static let headlineLarge:Font = Font.custom("Silkscreen-Regular", size: 16.0)
  
    static let mainHeadlineXSmall:Font = Font.custom("Pixeled", size: 9.0)
    static let mainHeadlineSmall:Font = Font.custom("Pixeled", size: 12.0)
    static let mainHeadlineMedium:Font = Font.custom("Pixeled", size: 14.0)
    static let mainHeadlineLarge:Font = Font.custom("Pixeled", size: 28.0)
    static let mainHeadlineXLarge:Font = Font.custom("Pixeled", size: 35.0)
}
