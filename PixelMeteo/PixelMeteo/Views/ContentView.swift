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
                Text("New Orleans")
                    .font(.mainHeadlineLarge)
                Text("Central City")
                    .font(.headlineMedium)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 0) {
                Label(weatherViewModel.currentTemperature, image: "sunrise")
                    .font(.mainHeadlineLarge)
                Text(weatherViewModel.weatherDescription)
                    .font(.headlineMedium)
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
    
    var MainHeader: some View {
        VStack {
            HStack {
                Label("\(weatherViewModel.snowfallAmount)", image: "snow")
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
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent et enim sit amet felis tincidunt venenatis eu et metus. Quisque elit ante, dictum sit amet sapien non, pulvinar finibus lacus.")
                .font(.headlineSmall)
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
                            Image("sunrise")
                            Text("\(hourForecast.formattedDay)")
                            Spacer()
                            Text("\(hourForecast.description)")
                            Text("\(hourForecast.temperature)")
                        }
                        .font(.headlineLarge)
                    }
                }
                .listStyle(.plain)
            }
        }
    }
    
    var MainTemperatureView: some View {
        VStack {
            Text(weatherViewModel.currentTemperature)
                .font(.mainTemperature)
                .background(.pink)
        }
    }
    
    var MainHouseView: some View {
        VStack {
            Image("house-cyberpunk")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TopHeader
                .task {
                    await weatherViewModel.getCurrentWeather()
                    await weatherViewModel.getWeeklyWeather()
                }
            MiddleHeader
            MainHouseView
            DailySummaryView
            Spacer()
            HourlyView
            WeeklyView
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

