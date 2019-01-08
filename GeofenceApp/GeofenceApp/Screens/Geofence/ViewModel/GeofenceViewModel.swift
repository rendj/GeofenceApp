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

    private let locationService: GeofenceLocationService
    var updateStatus: ((String) -> Void)!
    
    init(locationService: GeofenceLocationService) {
        self.locationService = locationService
    }
    
    func targetLocationWasPicked(location: CLLocation) {
        
    }
    
    func requestGeofenceStatus() {
        locationService.requestCurrentLocation { [weak self] (location, error) in
            switch (location, error) {
            case (let location?, nil):
                //TODO: - calculate actual status
                self?.updateStatus(".....")
            case (nil, let error?):
                self?.updateStatus(error.localizedDescription)
            default:
                self?.updateStatus("undefined...")
            }
        }
    }
}
