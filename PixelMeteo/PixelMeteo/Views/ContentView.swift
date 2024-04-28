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
        HStack(spacing: 0) {
            Button(action: { }) {
                Image("hamburger-menu")
            }
            Spacer()
            Text("\(weatherViewModel.cityDetail), \(weatherViewModel.city)")
                .font(.headlineSmall)
            Spacer()
            LocationButton() {
                weatherViewModel.requestLocation()
            }
            .labelStyle(.iconOnly)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    var DetailView: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Rain: \(weatherViewModel.chanceOfRain)%")
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Temperature: \(weatherViewModel.currentTemperature)")
                Text("Feels like: \(weatherViewModel.feelsLikeTemperature)")
                Text("High: \(weatherViewModel.high)")
                Text("Low: \(weatherViewModel.low)")
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Sunrise: \(weatherViewModel.sunrise)")
                Text("Sunset: \(weatherViewModel.sunset)")
            }
        }
        .font(.headlineSmall)
        .frame(maxWidth: .infinity, alignment: .top)
    }
    
    var WeeklyView: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(weatherViewModel.weatherDescription)
                .font(.mainHeadlineLarge)
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(weatherViewModel.dailyWeatherInfo) { daily in
                        VStack(alignment: .center, spacing: 0) {
                            Text("\(daily.day)")
                                .font(.mainHeadlineMedium)
                            Image("sunrise")
                            Text("\(daily.tempRange)")
                                .font(.mainHeadlineMedium)
                            Text("\(daily.description)")
                                .font(.headlineSmall)
                        }
                    }
                }
                .fixedSize()
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var MainTemperatureView: some View {
        HStack {
            Text(weatherViewModel.currentTemperature)
                .font(.mainTemperature)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("BackgroundColor"))
                .ignoresSafeArea()
            VStack(spacing: 0) {
                   TopHeader
                        .task {
                            await weatherViewModel.getCurrentWeather()
                            await weatherViewModel.getDailyWeather()
                        }
                   DetailView
                   MainTemperatureView
                   Spacer()
                   WeeklyView
            }
            .foregroundColor(Color("ForegroundColor"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

