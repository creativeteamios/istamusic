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
    
    var myLocation: CLLocationCoordinate2D?
    
    let database = Database()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        // Current position button
        let buttonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.rightBarButtonItem = buttonItem
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.delegate = self
            //centerMap(locationManager.location!.coordinate)
            if( (CLLocationManager.authorizationStatus() == .authorizedAlways) || (CLLocationManager.authorizationStatus() == .authorizedWhenInUse)){
                centerMap(locationManager.location!.coordinate)
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        addAnnotation()
    }
    
    // Current position
    func centerMap(_ center:CLLocationCoordinate2D){
        let spanX = 0.700
        let spanY = 0.700
        
        let newRegion = MKCoordinateRegion(center:center , span: MKCoordinateSpan(latitudeDelta: spanX, longitudeDelta: spanY))
        mapView.setRegion(newRegion, animated: true)
    }
    
    /*
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     let locValue:CLLocationCoordinate2D = manager.location!.coordinate
     
     centerMap(locValue)
     }
     */
    
    func addAnnotation() {
        for i in 0..<database.locations.count {
            let geoCoder = CLGeocoder()
            
            let annotation = MKPointAnnotation()
            annotation.title = database.imageBand[i]
            annotation.subtitle = database.locations[i]
            
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
        if( (CLLocationManager.authorizationStatus() == .authorizedAlways) || (CLLocationManager.authorizationStatus() == .authorizedWhenInUse)){
            centerMap(locationManager.location!.coordinate)
        }
        else{
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            
        }
    }

    
    func enableLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            //disableMyLocationBasedFeatures()
            break
            
        case .authorizedWhenInUse:
            // Enable basic location features
            //enableMyWhenInUseFeatures()
            break
            
        case .authorizedAlways:
            // Enable any of your app's location features
            //enableMyAlwaysFeatures()
            break
        }
    }
}

