//
//  DettaglioBandView.swift
//  istamusic
//
//  Created by Soriano Stefano on 14/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit

class DettaglioBandView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellSpacingHeight: CGFloat = 5
    let cellSpacingHeightBase: CGFloat = 0
    var recivedTag = ""
    var band = Band()
    @IBOutlet weak var imageBand: UIImageView!
    @IBOutlet weak var titoloBand: UILabel!
    @IBOutlet weak var descrizioneBand: UILabel!
    @IBOutlet weak var numeroFollower: UILabel!
    @IBOutlet weak var tabellaEventi: UITableView!
    @IBOutlet weak var infoBand: UILabel!
    @IBOutlet weak var ratedImage: UIImageView!
    @IBOutlet weak var mediaRated: UILabel!
    @IBOutlet weak var numeroRecesioni: UILabel!
    @IBOutlet weak var tabellaRecensioni: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configuro la tabella
        tabellaEventi.delegate = self
        tabellaEventi.dataSource = self
        tabellaEventi.allowsSelection = false
        
        //configuro la seconda tabella
        tabellaRecensioni.delegate = self
        tabellaRecensioni.dataSource = self
        tabellaRecensioni.allowsSelection = false
        
        tabellaEventi.dataSource = self

        // Do any additional setup after loading the view.
        band = dataBaseShared.bandFromTag(tag: recivedTag)
        setUpView()
        //print(recivedTag)
    }
    
    func setUpView(){
        imageBand.image = UIImage(named: band.image!)
        titoloBand.text = band.nomeGruppo
        descrizioneBand.text = band.genereMusicale
        numeroFollower.text = "\(band.follower!)"
        infoBand.text = band.descrizione
        mediaRated.text = "\(mediaVoti())"
        setImageRated(voto: mediaVoti())
        numeroRecesioni.text = "\(band.recensioni.count) recensioni"
        
    }
    
    func setImageRated(voto : Int){
        switch voto {
        case 1:
            ratedImage.image = UIImage(named: "1stelle")
        case 2:
            ratedImage.image = UIImage(named: "2stelle")
        case 3:
            ratedImage.image = UIImage(named: "3stelle")
        case 4:
            ratedImage.image = UIImage(named: "4stelle")
        case 5:
            ratedImage.image = UIImage(named: "5stelle")
        default:
            ratedImage.image = UIImage(named: "0stelle")
        }
    }
    
    func mediaVoti()-> Int{
        var media = 0
        for recensione in band.recensioni{
            media += recensione.votoRecensione!
        }
        return media/(band.recensioni.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tabellaEventi){
            return band.eventi.count
        }else{
            return band.recensioni.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == tabellaEventi){
            let cella = tableView.dequeueReusableCell(withIdentifier: "EventCellDettaglio", for: indexPath) as! TableSingleCellEventi
            
            let dfd = DateFormatter()
            dfd.dateFormat = "dd"
            let df = DateFormatter()
            df.dateFormat = "dd/MM/yyyy"
            let dfm = DateFormatter()
            dfm.dateFormat = "MM"
            
            cella.titleEvento.text = band.eventi[indexPath.row].nomeEvento
            cella.subTitleEvento.text = df.string(from : band.eventi[indexPath.row].dataEvento!)
            cella.genereEvento.text = "\(band.eventi[indexPath.row].numeroPartecipanti!) partecipanti"
            
            let imageGiorno = "giorno\(dfd.string(from: band.eventi[indexPath.row].dataEvento!))"
            cella.imageEvento.image = UIImage(named: imageGiorno)
            cella.imageEvento.layer.borderColor = UIColor.gray.cgColor
            cella.imageEvento.layer.borderWidth = 1
            
            return cella
        }else{
            let cella2 = tableView.dequeueReusableCell(withIdentifier: "EventCellRecensioni", for: indexPath) as! TableSingleCellRecensioni
            
            cella2.titoloRecensione.text = "\(band.recensioni[indexPath.row].titoloRecensione!)    \(band.recensioni[indexPath.row].nomePersona!)"
            cella2.testoRecensione.text = band.recensioni[indexPath.row].recensionetext
            cella2.immagineRecensione.image = UIImage(named: "\(band.recensioni[indexPath.row].votoRecensione!)stelle")
            
            return cella2
        }

    }
    
    @IBAction func segui(_ sender: Any) {
    }
    
    @IBAction func contatta(_ sender: Any) {
    }
    
    @IBAction func scriviRecesione(_ sender: Any) {
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
