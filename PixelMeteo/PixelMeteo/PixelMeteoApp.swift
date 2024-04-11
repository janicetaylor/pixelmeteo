//
//  PixelMeteoApp.swift
//  PixelMeteo
//
//  Created by Janice on 4/10/24.
//

import SwiftUI

@main
struct PixelMeteoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(weatherViewModel: WeatherViewModel())
        }
    }
}
