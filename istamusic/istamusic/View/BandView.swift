//
//  BandView.swift
//  istamusic
//
//  Created by Soriano Stefano on 13/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit
import CoreData

class BandView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionViewBand: UICollectionView!
    @IBOutlet weak var logButton: UIBarButtonItem!
    
    
    var index = 0
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vista = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCollection", for: indexPath) as! CollectionViewSingleCell
        
        vista.imageCollection.image = UIImage(named: dataBaseShared.bands[indexPath.row].image!)
        vista.imageCollection.layer.borderColor = UIColor.gray.cgColor
        vista.imageCollection.layer.borderWidth = 1
        
        
        vista.titleCollection.text = dataBaseShared.bands[indexPath.row].nomeGruppo
        vista.descrizioneCollection.text = dataBaseShared.bands[indexPath.row].genereMusicale
        
        return vista
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //inizializzo la collectionView
        collectionViewBand.delegate = self
        collectionViewBand.dataSource = self
        
        //ottengo i dati dal dispositivo
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UtenteRegistrato")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print("metodo uno")
            for data in result as! [NSManagedObject] {
                if(data.value(forKey: "nome") as? String) != nil {
                    print("utente \(data.value(forKey: "nome")) trovato")
                    gestoreUtenteShared.utente.nome = (data.value(forKey: "nome") as! String)
                    gestoreUtenteShared.utente.username = (data.value(forKey: "username") as! String)
                    gestoreUtenteShared.utente.password = (data.value(forKey: "password") as! String)
                }else{
                    print("utente non trovato")
                }
            }
            
        } catch {
            
            print("Failed")
        }

        if(gestoreUtenteShared.registrato()){
            logButton.title = "Log out"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(gestoreUtenteShared.registrato()){
            logButton.title = "Log out"
        }
    }
    
    func deleteRecords() {
        
        print("cancello i dati utenti")
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UtenteRegistrato")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    @IBAction func loginLogout(_ sender: Any) {
        if(logButton.title == "Log in"){
            performSegue(withIdentifier: "segueBandLogin", sender: 1)
        }else{
            gestoreUtenteShared.utente = Utente()
            logButton.title = "Log in"
        }
    }
    
    
    //Controllo collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataBaseShared.bands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("INDICE")
        //print(indexPath.row)
        index = indexPath.row
        performSegue(withIdentifier: "segueBand", sender: indexPath.row)
    }
    
    func eseguiLogout(){
        gestoreUtenteShared.utente = Utente()
        logButton.title = "Log in"
        deleteRecords()
        visualizzaErrorCredenzialiAlert(titolo: "Logout Avvenuto con successo", testo: "Hai effettuato correttamente il logout")
    }
    
    func visualizzaErrorCredenzialiAlert(titolo: String, testo: String){
        let alert = UIAlertController(title: titolo, message: testo, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let sender = sender as? Int else {
            return
        }
        
        if segue.identifier == "segueBand"{
                //print("INDICE 2")
                //print(collectionViewBand.indexPathsForSelectedItems[0])
                let destinationController = segue.destination as! DettaglioBandView
                let tag = dataBaseShared.bands[index].tag
                destinationController.recivedTag = tag!
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "segueBandLogin"){
            if(gestoreUtenteShared.registrato() == true){
                eseguiLogout()
                return false
            }
        }
        return true
    }
    

}
