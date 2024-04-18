//
//  ContentView.swift
//  PixelMeteo
//
//  Created by Janice on 4/10/24.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct ContentView: View {

    @ObservedObject var weatherViewModel: WeatherViewModel 
    @ObservedObject var locationManager = LocationManager()
    
    var TopHeader: some View {
        HStack {
            if let location = locationManager.location {
                Text("your location: \(location.latitude), \(location.longitude)")
            }
            LocationButton {
                locationManager.requestLocation()
            }
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
                Label("100%", image: "rain")
                Label("H:25", image: "highs")
                Label("L:25", image: "lows")
                Label("feels:25", image: "feels-like")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                Label("0%", image: "snow")
                Label("6:00am", image: "sunrise")
                Label("6:0pm", image: "sunset")
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .font(.sectionHeader)
    }
    
    var HourlyView: some View {
        VStack {
            List {
                Text("hourly ... ")
            }
        }
    }
    
    var WeeklyView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<3) { _ in
                    VStack {
                        let imageName: String = "wc-cloud"
                        Image(uiImage: UIImage(named: imageName)!)
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                        Text("Cloudy")
                            .font(.sectionHeader)
                        Text("12:00am")
                            .font(.sectionHeader)
                    }
                }
            }
        }
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            TopHeader
            Text("25")
                .font(.mainTemperature)
            MainHeader
            Spacer()
            WeeklyView
            HourlyView
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherViewModel: WeatherViewModel())
    }
}

