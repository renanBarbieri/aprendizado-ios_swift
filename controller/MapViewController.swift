//
//  MapViewController.swift
//  swiftTranning
//
//  Created by Thaciana Soares Goes de Lima on 22/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

import Foundation
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate{
    var contatos: [Contato] = Array()
    
    @IBOutlet var map: MKMapView!
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map.delegate = self
        
        self.contatos = ContatoDao.ContatoDaoInstance().contatos
        
        self.locationManager.requestWhenInUseAuthorization()
        
        let locallizationButton: MKUserTrackingBarButtonItem =
            MKUserTrackingBarButtonItem(mapView: self.map)
        
        self.navigationItem.rightBarButtonItem = locallizationButton

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.map.addAnnotations(self.contatos)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.map.removeAnnotations(self.contatos)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation.isKind(of: MKUserLocation.self)){
            return nil
        }
        
        let identifier:String = "pin"
        
        var pin:MKPinAnnotationView
        
        if let reusablePin:MKPinAnnotationView =
            mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            pin = reusablePin
        }else{
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        let contato:Contato = annotation as! Contato
        
        pin.pinTintColor = UIColor.red
        pin.canShowCallout = true
        
        if contato.photo != nil {
            let imagemContato: UIImageView = UIImageView(frame: CGRect( x: 0.0,
                                                                        y: 0.0,
                                                                        width: 62.0,
                                                                        height: 62.0) )
            imagemContato.image = contato.photo
            
            pin.leftCalloutAccessoryView = imagemContato
        }
        
        pin.frame = CGRect( x: 0.0,
                            y: 0.0,
                            width: 620.0,
                            height: 620.0)
        
        return pin
    }
    
}
