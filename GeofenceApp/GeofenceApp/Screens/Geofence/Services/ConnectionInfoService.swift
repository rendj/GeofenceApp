//
//  ConnectionInfoService.swift
//  GeofenceApp
//
//  Created by Andrii on 1/9/19.
//  Copyright © 2019 Andrii. All rights reserved.
//

import Foundation
import SystemConfiguration
import SystemConfiguration.CaptiveNetwork

class ConnectionInfoService {
    func wiFiHotspotName() -> String? {
        let interfaces = CNCopySupportedInterfaces()
        if interfaces != nil,
            let interfacesArray = CFBridgingRetain(interfaces) as? NSArray,
            interfacesArray.count > 0  {
            let interfaceName = interfacesArray.firstObject as! CFString
            let unsafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceName)! as Dictionary
            let interfaceData = unsafeInterfaceData as! Dictionary<String, AnyObject>
            let wiFiHotspotName = interfaceData["SSID"] as! String
            return wiFiHotspotName
        }
        return nil
    }
}
