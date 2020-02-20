//
//  ViewController.swift
//  GeoSeekPlayProject
//
//  Created by Brandi Bailey on 2/19/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController {
    
    @IBOutlet weak var myMapView: MGLMapView!
    
    var pressedLocation:CLLocation? = nil {
        didSet{
            //            continueButton.isEnabled = true
            //            continueButton.isHighlighted = true
            print("pressedLocation was set")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMapView()
        
    }
    
    func setMapView() {
        let mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.satelliteStyleURL)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 33.812794, longitude: -117.9190981), zoomLevel: 13, animated: false)
        
        view.addSubview(mapView)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = false
        mapView.addGestureRecognizer(lpgr)
    }
    
    //MARK: - UILongPressGestureRecognizer Action -
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            //When lognpress is start or running
        } else {
            print("I was long pressed...")
            
            let mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.satelliteStyleURL)
            let touchPoint = gestureReconizer.location(in: mapView)
            let coordsFromTouchPoint = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            pressedLocation = CLLocation(latitude: coordsFromTouchPoint.latitude, longitude: coordsFromTouchPoint.longitude)
            print("Location:", coordsFromTouchPoint.latitude, coordsFromTouchPoint.longitude)
            
            let wayAnnotation = MGLPointAnnotation()
            wayAnnotation.coordinate = coordsFromTouchPoint
            wayAnnotation.title = "waypoint"
            
        }
    }
}
