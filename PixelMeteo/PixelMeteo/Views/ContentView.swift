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
    @StateObject var locationManager = LocationManager()
    
    var TopHeader: some View {
        HStack(spacing: 0) {
            Button(action: { }) {
                Image("hamburger-menu")
            }
            Spacer()
            if locationManager.authorizationStatus == .authorizedWhenInUse {
                Text("\(locationManager.city), \(locationManager.cityDetail)")
                    .font(.headlineSmall)
                    .task {
                        await weatherViewModel.getCurrentWeather(location: locationManager.location)
                        await weatherViewModel.getDailyWeather(location: locationManager.location)
                    }
            }
            Spacer()
            LocationButton() {
                locationManager.requestLocation() 
            }
            .labelStyle(.iconOnly)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(0)
    }
    
    var TopCurrentHeaderView: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("\(weatherViewModel.weatherDescription)")
                .font(.mainHeadlineLarge)
            Spacer()
            Image("clear-icon-large")
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(0)
    }
    
    var TopRainView: some View {
        HStack(alignment: .top, spacing: 0) {
            Image("rain")
            Text("\(weatherViewModel.chanceOfRain)% chance of rain")
                .font(.headlineSmall)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(0)
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
                   TopCurrentHeaderView
                   TopRainView
                   Spacer()
                   MainTemperatureView
                   Spacer()
                    .frame(maxHeight: .infinity, alignment: .center)
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

