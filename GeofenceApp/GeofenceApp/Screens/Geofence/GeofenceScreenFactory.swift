//
//  GeofenceScreenFactory.swift
//  GeofenceApp
//
//  Created by Andrii on 1/8/19.
//  Copyright © 2019 Andrii. All rights reserved.
//

import UIKit

class GeofenceScreenFactory {
    func view() -> UIViewController {
        let geofenceViewController = GeofenceViewController.instantiate()
        let geofenceLocationService = GeofenceLocationService()
        let geofenceViewModel = GeofenceViewModel(locationService: geofenceLocationService)
        geofenceViewController.viewModel = geofenceViewModel
        return geofenceViewController;
    }
}
