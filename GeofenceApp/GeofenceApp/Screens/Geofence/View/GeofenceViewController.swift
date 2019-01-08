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
    
    @IBOutlet weak var mapViewTopContstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizer()
        setupNotifications()
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    @IBAction func checkGeofenceStatus(_ sender: Any) {
        
    }
}

extension GeofenceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension GeofenceViewController {
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let animationCurveRawValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            if wiFiHotspotNameTextField.frame.origin.y > endFrame.origin.y {
                mapViewTopContstraint.constant = endFrame.origin.y - wiFiHotspotNameTextField.frame.origin.y - wiFiHotspotNameTextField.frame.size.height
            } else {
                mapViewTopContstraint.constant = 0.0
            }
            let animationCurveOption = UIView.KeyframeAnimationOptions(rawValue: animationCurveRawValue)
            UIView.animateKeyframes(withDuration: animationDuration,
                                    delay: 0.0,
                                    options: animationCurveOption,
                                    animations: {
                                        self.view.layoutIfNeeded()
            },
                                    completion: nil)
        }
    }
}

