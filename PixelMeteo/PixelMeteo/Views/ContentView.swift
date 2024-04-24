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
            VStack(alignment: .leading, spacing: 0) {
                if let location = weatherViewModel.location {
                    Text("\(weatherViewModel.city)")
                        .font(.mainHeadlineLarge)
                    Text("\(weatherViewModel.cityDetail)")
                        .font(.headlineMedium)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 0) {
                LocationButton {
                     weatherViewModel.requestLocation()
                 }
                .symbolVariant(.fill)
                .labelStyle(.iconOnly)
                .foregroundColor(Color("ForegroundColor"))
                .font(.headlineSmall)
                .padding(.trailing, 5)
                Label(weatherViewModel.weatherDescription, systemImage: weatherViewModel.symbolName)
                    .font(.mainHeadlineLarge)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.leading, 5)
        .padding(.trailing, 5)
    }
    
    var MiddleHeader: some View {
        HStack(spacing: 0) {
            Label("H:\(weatherViewModel.high)", image: "highs")
                .padding(.trailing, 2)
            Label("L:\(weatherViewModel.low)", image: "lows")
                .padding(.trailing, 2)
            Label("feels like:\(weatherViewModel.feelsLikeTemperature)", image: "feels-like")
            Spacer()
            Label("\(weatherViewModel.precipitationChance)%", image: "rain")
                .padding(.trailing, 5)
            Label("\(weatherViewModel.humidity)%", image: "humidity")
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .font(.headlineMedium)
        .padding(.leading, 5)
        .padding(.trailing, 5)
        .padding(.top, 5)
    }
    
    var DayInfoHeader: some View {
        VStack {
            HStack {
                Label("\(weatherViewModel.snowfallAmount)", image: "snow")
                Spacer()
                Label("\(weatherViewModel.sunrise)", image: "sunrise")
                Label("\(weatherViewModel.sunset)", image: "sunset")
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .font(.headlineSmall)
    }
    
    var DailySummaryView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Daily Summary")
                .font(.mainHeadlineLarge)
            Text("The weather today in \(weatherViewModel.cityDetail), \(weatherViewModel.city) was \(weatherViewModel.weatherDescription). The average temperature was approximately \(weatherViewModel.currentTemperature). The chance of rain today is \(weatherViewModel.precipitationChance)%.")
                .font(.headlineMedium)
        }
        .padding(.leading, 5)
        .padding(.trailing, 5)
    }
    
    var HourlyView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Hourly Forecast")
                .font(.mainHeadlineLarge)
                .padding(.leading, 5)
                .padding(.trailing, 5)
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                        ForEach(weatherViewModel.hourlyInfo) { hourForecast in
                            VStack {
                                Text("\(hourForecast.formattedTime)")
                                    .font(.headlineSmall)
                                Image(uiImage: UIImage(named: "wc-storm")!)
                                Text("\(hourForecast.temperature)")
                                    .font(.headlineSmall)
                            }
                    }
                }
                .padding(.leading, 5)
                .padding(.trailing, 5)
            }
        }
    }
    
    var WeeklyView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Weekly Forecast")
                .font(.mainHeadlineLarge)
                .padding(.leading, 5)
                .padding(.trailing, 5)
            HStack {
                List {
                    ForEach(weatherViewModel.weeklyInfo) { hourForecast in
                        HStack {
                            Text("\(hourForecast.formattedDay)")
                            Spacer()
                            Text("\(hourForecast.description)")
                            Text("\(hourForecast.temperature)")
                        }
                        .font(.mainHeadlineXSmall)
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .background(Color.clear)
            }
        }
    }
    
    var MainTemperatureView: some View {
        VStack {
            Text(weatherViewModel.currentTemperature)
                .font(.mainTemperature)
        }
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
                        await weatherViewModel.getWeeklyWeather()
                    }
                MiddleHeader
                MainTemperatureView
                DayInfoHeader
                DailySummaryView
                Spacer()
                HourlyView
                WeeklyView
            }
        }
       .foregroundColor(Color("ForegroundColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

