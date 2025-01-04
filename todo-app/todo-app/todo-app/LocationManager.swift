//
//  LocationManager.swift
//  todo-app
//
//  Created by stud on 10/12/2024.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    @Published var userLocation:
    CLLocationCoordinate2D?
    private let locationManager = CLLocationManager()
    
    override init(){
        super.init()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager:
    CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            userLocation = location.coordinate
        }
    }
}
