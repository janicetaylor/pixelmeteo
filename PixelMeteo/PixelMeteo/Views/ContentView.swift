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
                Label("10%", image: "rain")
                Label("H:80", image: "highs")
                Label("L:70", image: "lows")
                Label("feels:75", image: "feels-like")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                Label("0%", image: "snow")
                Label("17km/h", image: "wind")
                Label("6:00am", image: "sunrise")
                Label("6:00pm", image: "sunset")
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
                .minimumScaleFactor(0.01)
                .aspectRatio(contentMode: .fit)
            MainHeader
        }.task {
            await weatherViewModel.fetchData()
        }
    }
}

#Preview {
    // bad!!!
    ContentView(weatherViewModel: WeatherViewModel())
}
