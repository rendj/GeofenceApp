//
//  GeofenceViewModel.swift
//  GeofenceApp
//
//  Created by Andrii on 1/8/19.
//  Copyright © 2019 Andrii. All rights reserved.
//

import Foundation
import CoreLocation

class GeofenceViewModel {
    let calculatingStatusTitle = "Calculating..."
    
    private var model: GeofenceModel
    private let locationService: GeofenceLocationService
    private let connectionService: ConnectionInfoService
    
    var updateStatus: ((String) -> Void)!
    var startLocationDetectionActivity: (() -> Void)!
    var endLocationDetectionActivity: (() -> Void)!
    
    init(locationService: GeofenceLocationService, connectionService: ConnectionInfoService, model: GeofenceModel) {
        self.locationService = locationService
        self.connectionService = connectionService
        self.model = model
    }
    
    func targetLocationWasPicked(location: CLLocation) {
        model = model.updateLongitude(with: location.coordinate.longitude).updateLattitude(with: location.coordinate.latitude)
    }
    
    func radiusWasPicked(radius: UInt) {
        model = model.updateRadius(with: radius)
    }
    
    func wiFiHotspotNameWasPicked(name: String) {
        model = model.updateWiFiHotspotName(with: name)
    }
    
    func requestGeofenceStatus() {
        startLocationDetectionActivity()
        if self.model.wiFiHotspotName == self.connectionService.wiFiHotspotName() {
            endLocationDetectionActivity()
            updateStatus("INSIDE")
        } else {
            locationService.requestCurrentLocation { [weak self] (currentLocation, error) in
                self?.endLocationDetectionActivity()
                switch (currentLocation, error) {
                case (let currentLocation?, nil):
                    let pickedLocation = CLLocation(latitude: (self?.model.lattitude)!, longitude: (self?.model.longitude)!)
                    if UInt(pickedLocation.distance(from: currentLocation)) < (self?.model.radius)! {
                        self?.updateStatus("INSIDE")
                    } else {
                        self?.updateStatus("OUTSIDE")
                    }
                case (nil, let error?):
                    self?.updateStatus(error.localizedDescription)
                default:
                    self?.updateStatus("undefined...")
                }
            }
        }
    }
    
    func finalString(from main:String, replacement: String) -> String {
        var finalString = main
        if !replacement.isEmpty {
            finalString += replacement
        } else {
            finalString.removeLast()
        }
        return finalString
    }
    
    func uint(from string: String) -> UInt {
        return UInt(string) ?? UInt(0)
    }
}
