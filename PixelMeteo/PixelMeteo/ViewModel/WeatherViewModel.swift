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
    
    @Published var weather: CurrentWeather?
        
    override init() {
        super.init()
        manager.delegate = self
    }
    
    var currentWeather: String {
        let converted = weather?.temperature.converted(to: .fahrenheit).description
        return converted ?? "getting weather data..."
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])  {
        locationCoordinate = locations.first?.coordinate
        location = locations.first
        print("location: \(location)")
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
            let location = CLLocation(latitude: 29.9511, longitude: 90.0715)
            weather = try await WeatherService.shared.weather(for: location, including: .current)
        } catch {
            fatalError("can't get current weather")
        }
    }
    
    
    
}
