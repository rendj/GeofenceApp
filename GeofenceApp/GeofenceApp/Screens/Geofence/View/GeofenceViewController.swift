//
//  ViewController.swift
//  GeofenceApp
//
//  Created by Andrii on 1/8/19.
//  Copyright © 2019 Andrii. All rights reserved.
//

import UIKit
import MapKit

class GeofenceViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var areaRadiusTestField: UITextField!
    @IBOutlet weak var wiFiHotspotNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func checkGeofenceStatus(_ sender: Any) {
    }
}
