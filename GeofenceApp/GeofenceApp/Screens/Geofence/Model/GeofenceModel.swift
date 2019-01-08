//
//  GeofenceModel.swift
//  GeofenceApp
//
//  Created by Andrii on 1/8/19.
//  Copyright © 2019 Andrii. All rights reserved.
//

import Foundation

struct GeofenceModel {
    private(set) var lattitude: Double
    private(set) var longitude: Double
    private(set) var radius: UInt
    private(set) var wiFiHotspotName: String
}

extension GeofenceModel {
    
    func updateLattitude(with newValue: Double) -> GeofenceModel {
        var newModel = self
        newModel.lattitude = newValue
        return newModel
    }
    
    func updateLongitude(with newValue: Double) -> GeofenceModel {
        var newModel = self
        newModel.longitude = newValue
        return newModel
    }
    
    func updateRadius(with newValue: UInt) -> GeofenceModel {
        var newModel = self
        newModel.radius = newValue
        return newModel
    }
    
    func updateWiFiHotspotName(with newValue: String) -> GeofenceModel {
        var newModel = self
        newModel.wiFiHotspotName = newValue
        return newModel
    }
    
}
