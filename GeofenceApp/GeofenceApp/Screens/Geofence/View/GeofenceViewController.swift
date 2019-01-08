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
    
    var viewModel: GeofenceViewModel! {
        didSet {
            setupViewModelBindings()
        }
    }

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var areaRadiusTestField: UITextField!
    @IBOutlet weak var wiFiHotspotNameTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var locationCheckingActivityView: UIActivityIndicatorView!
    
    @IBOutlet weak var mapViewTopContstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizer()
        setupNotifications()
    }
    
    private func setupViewModelBindings() {
        viewModel.updateStatus = { [weak self] status in
            self?.statusLabel.text = status
        }
        viewModel.startLocationDetectionActivity = { [weak self] in
            //TODO: - move string to the Model
            self?.statusLabel.text = "Calculating..."
            self?.checkButton.isEnabled = false
            self?.mapView.isUserInteractionEnabled = false
            self?.locationCheckingActivityView.startAnimating()
        }
        viewModel.endLocationDetectionActivity =  { [weak self] in
            self?.checkButton.isEnabled = true
            self?.mapView.isUserInteractionEnabled = true
            self?.locationCheckingActivityView.stopAnimating()
        }
    }
    
    private func setupGestureRecognizer() {
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(singleTapGesture)
        
        let mapViewSingleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMapView))
        mapViewSingleTapGesture.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(mapViewSingleTapGesture)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    @IBAction func checkGeofenceStatus(_ sender: Any) {
        viewModel.requestGeofenceStatus()
    }
}

extension GeofenceViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case areaRadiusTestField:
            //TODO: - is it make sense to get rid of "!"?
            viewModel.radiusWasPicked(radius: UInt(textField.text! + string)!)
        case wiFiHotspotNameTextField:
            viewModel.wiFiHotspotNameWasPicked(name: textField.text! + string)
        default: break
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension GeofenceViewController {
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func didTapMapView(recognizer: UITapGestureRecognizer) -> Void {
        let existingAnnotations = mapView.annotations.filter { annotation in
            !(annotation is MKUserLocation)
        }
        mapView.removeAnnotations(existingAnnotations)
        let tapLocation = recognizer.location(in: mapView)
        let mapCoordinate = mapView.convert(tapLocation, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapCoordinate
        mapView.addAnnotation(annotation)
        let pickedLocation = CLLocation(latitude: mapCoordinate.latitude, longitude: mapCoordinate.longitude)
        viewModel.targetLocationWasPicked(location: pickedLocation)
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

