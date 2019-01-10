//
//  GeofenceModelTests.swift
//  GeofenceAppTests
//
//  Created by Andrii on 1/10/19.
//  Copyright © 2019 Andrii. All rights reserved.
//

import XCTest
@testable import GeofenceApp

class GeofenceModelTests: XCTestCase {
    
    let defaultLattitude = 10.0
    let defaultLongitude = 10.0
    let defaultRadius = UInt(10)
    let defaultWiFiHotspotName = "wiFiHotspot"
    
    var model: GeofenceModel!
    
    override func setUp() {
        model = GeofenceModel(lattitude: defaultLattitude, longitude: defaultLongitude, radius: defaultRadius, wiFiHotspotName: defaultWiFiHotspotName)
    }
    
    override func tearDown() {
        model = nil
    }

    func testGeofenceModelShouldBeInitializedProperly() {
        XCTAssertEqual(model.lattitude, defaultLattitude, "GeofenceModel lattitude should be equal to the value passed during initialization")
        XCTAssertEqual(model.longitude, defaultLongitude, "GeofenceModel longitude should be equal to the value passed during initialization")
        XCTAssertEqual(model.radius, defaultRadius, "GeofenceModel radius should be equal to the value passed during initialization")
        XCTAssertEqual(model.wiFiHotspotName, defaultWiFiHotspotName, "GeofenceModel defaultWiFiHotspotName should be equal to the value passed during initialization")
    }
    
    func testGeofenceModelUpdateLattitudeShouldBehaveProperly() {
        let newModel = model.updateLattitude(with: 20.0)
        XCTAssertEqual(newModel.lattitude, 20.0, "GeofenceModel lattitude should be changed after updateLattitude was called")
        XCTAssertEqual(newModel.longitude, defaultLongitude, "GeofenceModel longitude should be equal to the value passed during initialization")
        XCTAssertEqual(newModel.radius, defaultRadius, "GeofenceModel radius should be equal to the value passed during initialization")
        XCTAssertEqual(newModel.wiFiHotspotName, defaultWiFiHotspotName, "GeofenceModel defaultWiFiHotspotName should be equal to the value passed during initialization")
    }
    
    func testGeofenceModelUpdateLongitudeShouldBehaveProperly() {
        let newModel = model.updateLongitude(with: 20.0)
        XCTAssertEqual(newModel.lattitude, defaultLattitude, "GeofenceModel lattitude should be equal to the value passed during initialization")
        XCTAssertEqual(newModel.longitude, 20.0, "GeofenceModel longitude should be changed after updateLongitude was called")
        XCTAssertEqual(newModel.radius, defaultRadius, "GeofenceModel radius should be equal to the value passed during initialization")
        XCTAssertEqual(newModel.wiFiHotspotName, defaultWiFiHotspotName, "GeofenceModel defaultWiFiHotspotName should be equal to the value passed during initialization")
    }
    
    func testGeofenceModelUpdateRadiusShouldBehaveProperly() {
        let newModel = model.updateRadius(with: 20)
        XCTAssertEqual(newModel.lattitude, defaultLattitude, "GeofenceModel lattitude should be equal to the value passed during initialization")
        XCTAssertEqual(newModel.longitude, defaultLongitude, "GeofenceModel longitude should be equal to the value passed during initialization")
        XCTAssertEqual(newModel.radius, 20, "GeofenceModel radius should be changed after updateRadius was called")
        XCTAssertEqual(newModel.wiFiHotspotName, defaultWiFiHotspotName, "GeofenceModel defaultWiFiHotspotName should be equal to the value passed during initialization")
    }
    
    func testGeofenceModelUpdateWiFiHotspotNameShouldBehaveProperly() {
        let newModel = model.updateWiFiHotspotName(with: "newWiFiHotspot")
        XCTAssertEqual(newModel.lattitude, defaultLattitude, "GeofenceModel lattitude should be equal to the value passed during initialization")
        XCTAssertEqual(newModel.longitude, defaultLongitude, "GeofenceModel longitude should be equal to the value passed during initialization")
        XCTAssertEqual(newModel.radius, defaultRadius, "GeofenceModel radius should be equal to the value passed during initialization")
        XCTAssertEqual(newModel.wiFiHotspotName, "newWiFiHotspot", "GeofenceModel wiFiHotspotName should be changed after updateWiFiHotspotName was called")
    }
}
