//
//  EventiView.swift
//  istamusic
//
//  Created by Soriano Stefano on 11/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit
import MapKit

class EventiView: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mappaEventi: MKMapView!
    @IBOutlet weak var tableEventi: UITableView!
    
    
    var annotation = MKPointAnnotation()
    let geoCoder = CLGeocoder()
    var provincia: String?
    var locationResul = [Evento]()
    var mappaActive = false
    
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
        
        //configuro la tabella
        tableEventi.delegate = self
        tableEventi.dataSource = self
    }
    //gestione tab sulla mappa
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
                                                print(self.provincia)
                                                self.reload()
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
    //funzione chiamata quando premo sulla mappa e serve per ricaricare il db
    func reload(){
        //print("chiamato metodo prima \(provincia)")
        if(provincia != nil){
            //print("reload")
            mappaActive = true
            
            filterContent(for: provincia!)
            tableEventi.reloadData()
        }
    }
    
    //filtro località
    func filterContent(for searchText: String ){
        
        locationResul = dataBaseShared.eventiaaa.filter({(evento) -> Bool in
            let indirizzo = evento.indirizzoEvento!
            if(indirizzo.localizedCaseInsensitiveContains(searchText) == true || searchText.localizedCaseInsensitiveContains(indirizzo) == true){
                
                //print("\(searchText) \(band.nomeGruppo!) \(band.genereMusicale)")
                return true
            }
            return false
        })
    }

    //Gestione Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(mappaActive){
            return locationResul.count+1
        }
        return dataBaseShared.eventiaaa.count+1
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celltitolo = tableView.dequeueReusableCell(withIdentifier: "EventiCellTitolo", for: indexPath) as! TableSingleGiornoEventi
        let cellEvntList = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! TableSingleCellEventi
        var dB = [Evento]()
        let dfd = DateFormatter()
        dfd.dateFormat = "dd"
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let dfm = DateFormatter()
        dfm.dateFormat = "MM"
        
        //print("elemnti nel db \(dataBaseShared.eventiaaa.count)")
        if(mappaActive){
            let arra = provincia!.split(separator: " ")
            let prov = arra[arra.count-1]
            celltitolo.singoloGiornoText.text = "Prossimi Eventi a \(prov)"
            dB = locationResul
        }else{
            celltitolo.singoloGiornoText.text = "Prossimi Eventi in tutto il mondo"
            dB = dataBaseShared.eventiaaa
        }
        
        if(indexPath.row == 0){
            return celltitolo
        }else{
            cellEvntList.titleEvento.text = dB[indexPath.row-1].nomeEvento
            cellEvntList.subTitleEvento.text = df.string(from : dB[indexPath.row-1].dataEvento!)
            cellEvntList.genereEvento.text = "\(dB[indexPath.row-1].numeroPartecipanti!) partecipanti"
            
            let imageGiorno = "giorno\(dfd.string(from: dB[indexPath.row-1].dataEvento!))"
            cellEvntList.imageEvento.image = UIImage(named: imageGiorno)
            cellEvntList.imageEvento.layer.borderColor = UIColor.gray.cgColor
            cellEvntList.imageEvento.layer.borderWidth = 1
            return cellEvntList
        }
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
