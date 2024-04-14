//
//  PixelMeteoApp.swift
//  PixelMeteo
//
//  Created by Janice on 4/10/24.
//

import SwiftUI

@main
struct PixelMeteoApp: App {
    @StateObject var weatherViewModel = WeatherViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(weatherViewModel: weatherViewModel)
        }
    }
}
