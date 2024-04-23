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

    @ObservedObject var weatherViewModel = WeatherViewModel()
    
    var TopHeader: some View {
        HStack(spacing: 5) {
            VStack(alignment: .leading) {
                if let location = weatherViewModel.location {
                    Text("\(weatherViewModel.city)")
                        .font(.mainHeadlineLarge)
                    Text("\(weatherViewModel.cityDetail)")
                        .font(.headlineSmall)
                }
            }
            Spacer()
            LocationButton {
                weatherViewModel.requestLocation()
            }.font(.headlineSmall)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var MainHeader: some View {
        VStack {
            HStack {
                Label("\(weatherViewModel.precipitationChance)%", image: "rain")
                Label("humidity:\(weatherViewModel.humidity)%", image: "rain")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                Label("H:\(weatherViewModel.high)", image: "highs")
                Label("L:\(weatherViewModel.low)", image: "lows")
                Label("feels:\(weatherViewModel.feelsLikeTemperature)", image: "feels-like")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                Label("\(weatherViewModel.snowfallAmount)", image: "snow")
                Label("\(weatherViewModel.sunrise)", image: "sunrise")
                Label("\(weatherViewModel.sunset)", image: "sunset")
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .font(.headlineSmall)
    }
    
    var HourlyView: some View {
        VStack {
            List {
                ForEach(weatherViewModel.hourlyInfo) { hourForecast in
                    Text("\(hourForecast.temperature) \(hourForecast.time)")
                        .font(.headlineSmall)
                }
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
                            .font(.headlineLarge)
                        Text("12:00am")
                            .font(.headlineSmall)
                    }
                }
            }
        }
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            TopHeader
            Text(weatherViewModel.currentTemperature)
                .task {
                    await weatherViewModel.getCurrentWeather()
                }
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
        ContentView()
    }
}

