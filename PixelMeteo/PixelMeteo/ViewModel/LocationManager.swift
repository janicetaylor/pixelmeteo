//
//  LocationManager.swift
//  PixelMeteo
//
//  Created by Janice on 4/18/24.
//

import Foundation
import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        fatalError("unable to get location: \(error)")
    }
    
    
}
