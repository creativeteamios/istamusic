//
//  MapView.swift
//  istamusic
//
//  Created by Mariniello Umberto on 14/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class MapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var buttonItem: MKUserTrackingBarButtonItem = MKUserTrackingBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Current position button
        buttonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.rightBarButtonItem = buttonItem
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        addAnnotation()
    }
    
    // Current position
    func centerMap(_ center: CLLocationCoordinate2D){
        let spanX = 0.700
        let spanY = 0.700
        
        let newRegion = MKCoordinateRegion(center: center , span: MKCoordinateSpan(latitudeDelta: spanX, longitudeDelta: spanY))
        mapView.setRegion(newRegion, animated: true)
    }
    
    // Shows database items on map
    func addAnnotation() {
        for i in 0..<dataBaseShared.bands.count {
            let geoCoder = CLGeocoder()
            
            let annotation = MKPointAnnotation()
            annotation.title = dataBaseShared.bands[i].nomeGruppo
            annotation.subtitle = dataBaseShared.bands[i].location
            
            geoCoder.geocodeAddressString(annotation.subtitle!, completionHandler: { placemarks, error in
                if let error = error {
                    print(error)
                    return
                }
                
                if let placemarks = placemarks {
                    let placemark = placemarks[0]
                    
                    if let location = placemark.location {
                        annotation.coordinate = location.coordinate
                        //self.mapView.showAnnotations([annotation], animated: true)
                        //self.mapView.selectAnnotation(annotation, animated: true)
                    }
                }
            })
            mapView.addAnnotation(annotation)
        }
    }
    
    // MARK: - MKMapViewDelegate methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyMarker"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        // Reuse the annotation if possible
        var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView?.glyphText = "🎸" //command + control + space per inserire le emoticon
        annotationView?.markerTintColor = UIColor.orange
        
        return annotationView
        
    }
    
    // Override MKUserTrackingBarButtonItem button
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        if ((CLLocationManager.authorizationStatus() == .authorizedAlways) || (CLLocationManager.authorizationStatus() == .authorizedWhenInUse)) {
            centerMap(locationManager.location!.coordinate)
        }
        else {
            let alert: UIAlertController = UIAlertController(title: "Please go to istamusic Settings and turn on permissions", message: nil, preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            }
            present(alert, animated: true, completion: nil)
            alert.addAction(settingsAction)
        }
    }
}
