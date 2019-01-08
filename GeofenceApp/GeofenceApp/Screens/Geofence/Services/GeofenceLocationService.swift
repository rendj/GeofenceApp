//
//  GeofenceLocationService.swift
//  GeofenceApp
//
//  Created by Andrii on 1/8/19.
//  Copyright © 2019 Andrii. All rights reserved.
//

import Foundation
import CoreLocation

class GeofenceLocationService: NSObject {
    
    private var locationCallback: ((CLLocation?, Error?) -> Void)?
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    func requestCurrentLocation(callback: @escaping (CLLocation?, Error?) -> Void) {
        locationCallback = callback
        locationManager.requestLocation()
    }
    
    private func requestLocationPermissions() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
}

extension GeofenceLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first,
            let callback = locationCallback {
                callback(location, nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let callback = locationCallback {
            callback(nil, error)
        }
    }
}
