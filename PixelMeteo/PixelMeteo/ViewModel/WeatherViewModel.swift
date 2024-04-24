//
//  LocationManager.swift
//  PixelMeteo
//
//  Created by Janice on 4/18/24.
//

import Foundation
import CoreLocation
import CoreLocationUI
import WeatherKit

class WeatherViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    let manager = CLLocationManager()
    
    @Published var locationCoordinate: CLLocationCoordinate2D?
    @Published var location: CLLocation?
    @Published var city: String = ""
    @Published var cityDetail: String = ""
    
    @Published var weather: Weather?
    @Published var currentTemperature: String = ""
    @Published var feelsLikeTemperature: String = ""
    @Published var high: String = ""
    @Published var low: String = ""
    @Published var humidity: Int = 0
    @Published var snowfallAmount: String = ""
    @Published var precipitationChance: Int = 0
    @Published var sunrise: String = ""
    @Published var sunset: String = ""
    @Published var weeklyInfo:[WeatherInfo] = []
    @Published var hourlyInfo:[WeatherInfo] = []
    @Published var weatherDescription: String = ""
        
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])  {
        locationCoordinate = locations.first?.coordinate
        location = locations.first
        print("location: \(location), \(location!.coordinate.latitude), \(location!.coordinate.longitude)")
        if let location = locations.first {
            getPlace(from: location)
        } else {
            fatalError("cannot get location")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        fatalError("unable to get location: \(error)")
    }
    
    func getPlace(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [self] (placemarks, error) in
            if let placemarks = placemarks {
                city = placemarks.first?.locality ?? "New Orleans"
                cityDetail = placemarks.first?.subLocality ?? "2233 St. Charles Avenue"
            }
            else {
                fatalError("error getting placemark: \(error?.localizedDescription ?? "error getting placemark")")
            }
        }
    }
    
    @MainActor
    func getCurrentWeather() async {
        do {
            let location = CLLocation(latitude: 29.93383411, longitude: -90.08174409)
            weather = try await WeatherService.shared.weather(for: location)
            if let weather = weather {
                updateWeatherValues(weather: weather)
                weatherDescription = weather.currentWeather.condition.description
            }
                        
        } catch {
            fatalError("can't get current weather")
        }
    }
    
    // refactor 
    
    @MainActor
    func getWeeklyWeather() async {
        do {
            let location = CLLocation(latitude: 29.93383411, longitude: -90.08174409)
            let calendar = Calendar.current
            let formatter = DateFormatter()
            let startDate = Date()
            if let endDate = calendar.date(byAdding: .day, value: 7, to: startDate) {
                let weeklyForecast = try await WeatherService.shared.weather(for: location, including: .hourly(startDate: startDate, endDate: endDate))
                for hourly in weeklyForecast {
                    let hourlyTemp = hourly.temperature.truncateTemperature(measurement: hourly.temperature, unit: .fahrenheit)
                    let hourlyDate = hourly.date.truncateToHour(dateToFormat: hourly.date)
                    let hourlyDay = hourly.date.truncateToDay(dateToFormat: hourly.date)
                    let info: WeatherInfo = WeatherInfo(temperature: hourlyTemp, time: hourly.date, formattedTime: hourlyDate, formattedDay: hourlyDay, description: hourly.condition.description)
                    weeklyInfo.append(info)
                    if calendar.isDateInToday(info.time) {
                        hourlyInfo.append(info)
                    }
                    print(hourlyInfo)
                }
            }
        } catch {
            fatalError("can't get weekly weather")
        }
    }
    
    func updateWeatherValues(weather: Weather) {
        let temp = weather.currentWeather.temperature
        currentTemperature = temp.truncateTemperature(measurement: temp, unit: .fahrenheit)
    
        let apparentTemp = weather.currentWeather.apparentTemperature
        feelsLikeTemperature = apparentTemp.truncateTemperature(measurement: apparentTemp, unit: .fahrenheit)
        humidity = Int(weather.currentWeather.humidity*100)
        
        if let dailyForecast = weather.dailyForecast.first {
            let highTemp = dailyForecast.highTemperature
            high = highTemp.truncateTemperature(measurement: highTemp, unit: .fahrenheit)
            
            let lowTemp = dailyForecast.lowTemperature
            low = lowTemp.truncateTemperature(measurement: lowTemp, unit: .fahrenheit)
            
            precipitationChance = Int(dailyForecast.precipitationChance)
            snowfallAmount = dailyForecast.snowfallAmount.formatted()
            
        } else {
            fatalError("can't get daily forecast")
        }
        
        if let sunEvents = weather.dailyForecast.first?.sun {
            sunrise = sunEvents.sunrise?.formatted(date: .omitted, time: .shortened) ?? ""
            sunset = sunEvents.sunset?.formatted(date: .omitted, time: .shortened) ?? ""
        } else {
            fatalError("can't get daily sun events")
        }
        
        
        
    }
    
}
