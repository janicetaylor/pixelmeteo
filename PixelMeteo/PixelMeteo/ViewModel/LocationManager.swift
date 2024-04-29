//
//  LocationManager.swift
//  PixelMeteo
//
//  Created by Janice on 4/28/24.
//

import Foundation
import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    let manager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
        
    @Published var locationCoordinate: CLLocationCoordinate2D?
    @Published var location: CLLocation = CLLocation(latitude: 29.93383411, longitude: -90.08174409)
    @Published var city: String = ""
    @Published var cityDetail: String = ""
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedWhenInUse:
                authorizationStatus = .authorizedWhenInUse
                manager.requestLocation()
                guard let location = manager.location else { return }
                getPlace(from: location)
                break
            case .restricted:
                authorizationStatus = .restricted
                break
            case .denied:
                authorizationStatus = .denied
                break
            case .notDetermined:
                authorizationStatus = .notDetermined
                manager.requestWhenInUseAuthorization()
                manager.startUpdatingLocation()
                break
            default:
                break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])  {
        locationCoordinate = locations.first?.coordinate
        location = locations.first ?? location
        print("location: \(location), \(location.coordinate.latitude), \(location.coordinate.longitude)")
        if let location = locations.first {
            getPlace(from: location)
            
        } else {
            fatalError("cannot get location")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        fatalError("unable to get location \(error)")
    }
    
    func getPlace(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [self] (placemarks, error) in
            if let placemarks = placemarks {
                city = placemarks.first?.locality ?? "New Orleans"
                cityDetail = placemarks.first?.subLocality ?? "2233 St. Charles Avenue"
                print("getPlace : \(city) \(cityDetail)")
            }
            else {
                fatalError("error getting placemark: \(error?.localizedDescription ?? "error getting placemark")")
            }
        }
    }
    
}
