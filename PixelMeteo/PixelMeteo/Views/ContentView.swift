//
//  ContentView.swift
//  PixelMeteo
//
//  Created by Janice on 4/10/24.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var weatherViewModel: WeatherViewModel 
    
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
                Label("\(weatherViewModel.rain)%", image: "rain")
                Label("H:\(weatherViewModel.currentTemperatureHigh)", image: "highs")
                Label("L:\(weatherViewModel.currentTemperatureLow)", image: "lows")
                Label("feels:\(weatherViewModel.apparentTemperature)", image: "feels-like")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                Label("\(weatherViewModel.snowfall)%", image: "snow")
                Label("\(weatherViewModel.todaySunrise)", image: "sunrise")
                Label("\(weatherViewModel.todaySunset)", image: "sunset")
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .font(.sectionHeader)
    }
    
    var HourlyView: some View {
        VStack {
            List {
                ForEach(weatherViewModel.hourlyWeathers) { hourlyWeather in
                    Text("\(hourlyWeather.time) \(Int(hourlyWeather.temperature))")
                 }
            }
        }
    }
    
    var WeeklyView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(weatherViewModel.dailyWeathers) { dailyWeather in
                    VStack {
                        let imageName: String = weatherViewModel.getImageNameForWeatherCode(code: dailyWeather.weather_code)
                        Image(uiImage: UIImage(named: imageName)!)
                        Text("\(weatherViewModel.shortWeatherDescription(for: dailyWeather.weather_code))")
                            .font(.sectionHeader)
                        Text("\(dailyWeather.time)")
                            .font(.sectionHeader)
                    }
                }
            }
        }
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            TopHeader
            Text("\(weatherViewModel.currentTemperature)")
                .font(.mainTemperature)
            MainHeader
            WeeklyView 
            HourlyView
        }.task {
            await weatherViewModel.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherViewModel: WeatherViewModel())
    }
}

