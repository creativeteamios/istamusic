//
//  EventiView.swift
//  istamusic
//
//  Created by Soriano Stefano on 11/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit
import MapKit

class EventiView: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var mappaEventi: MKMapView!
    var annotation = MKPointAnnotation()
    let geoCoder = CLGeocoder()
    var provincia: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize the map view
        mappaEventi.delegate = self
        mappaEventi.showsCompass = true
        mappaEventi.showsScale = true
        mappaEventi.showsTraffic = true
        
        //controllo delle gesture sulla mappa
        let gestureRecognized = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        gestureRecognized.delegate = self
        mappaEventi.addGestureRecognizer(gestureRecognized)
    }
    
    @objc func handleTap(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: mappaEventi)
        let coordinate = mappaEventi.convert(location,toCoordinateFrom: mappaEventi)
        
        // Add annotation:
        annotation.coordinate = coordinate
        mappaEventi.addAnnotation(annotation)
        
        
        // Look up the location and pass it to the completion handler
        let center = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(center,
                                        completionHandler: { (placemarks, error) in
                                            if error == nil {
                                                let firstLocation = placemarks?[0]
                                                //Provincia
                                                self.provincia = firstLocation?.subAdministrativeArea
                                                //print(firstLocation?.subAdministrativeArea)
                                                //completionHandler(center)
                                            }
                                            else {
                                                // An error occurred during geocoding.
                                                //completionHandler(nil)
                                                print("Erore Localizzazione")
                                            }
        })
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
