//
//  MapViewController.swift
//  swiftTranning
//
//  Created by Thaciana Soares Goes de Lima on 22/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

import Foundation
import MapKit

class MapViewController : UIViewController{
    
    @IBOutlet var map: MKMapView!
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        let locallizationButton: MKUserTrackingBarButtonItem =
            MKUserTrackingBarButtonItem(mapView: self.map)
        
        self.navigationItem.rightBarButtonItem = locallizationButton

    }
    
}
