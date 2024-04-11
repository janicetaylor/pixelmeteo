//
//  ContentView.swift
//  PixelMeteo
//
//  Created by Janice on 4/10/24.
//

import SwiftUI

struct ContentView: View {
    var weatherViewModel: WeatherViewModel
    
    var TopHeader: some View {
        HStack {
            Text("New Orleans")
            Text("Cloudy")
            Text("Favorite Cities")
            Text("Search")
        }
        .font(.sectionHeader)
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var MainHeader: some View {
        VStack {
            HStack {
                Text("rain: 10%")
                Text("high: 60")
                Text("low: 70")
                Text("feels like: 20")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                Text("snow: 0%")
                Text("wind: 17km/h")
                Text("sunrise: 6:00")
                Text("sunset: 8pm")
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .font(.sectionHeader)
    }
    
    
    var body: some View {
        VStack() {
            TopHeader
            Text("68")
                .font(.mainTemperature)
            MainHeader
        }
    }
}

#Preview {
    ContentView(weatherViewModel: WeatherViewModel())
}
