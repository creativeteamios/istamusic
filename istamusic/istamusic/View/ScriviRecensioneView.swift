//
//  ScriviRecensioneView.swift
//  istamusic
//
//  Created by Soriano Stefano on 15/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit

class ScriviRecensioneView: UIViewController {
    
    @IBOutlet weak var stella1: UIButton!
    @IBOutlet weak var stella2: UIButton!
    @IBOutlet weak var stella3: UIButton!
    @IBOutlet weak var stella4: UIButton!
    @IBOutlet weak var stella5: UIButton!
    
    @IBOutlet weak var titoloRecensione: UITextField!
    @IBOutlet weak var nomeUtente: UITextField!
    @IBOutlet weak var descrizioneRecensione: UITextView!
    
    var tagBand = ""
    var votoRecensione = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(tagBand)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func stellaUno(_ sender: Any) {
        
        stella2.imageView?.image = UIImage(named: "stellaVuota")
        stella3.imageView?.image = UIImage(named: "stellaVuota")
        stella4.imageView?.image = UIImage(named: "stellaVuota")
        stella5.imageView?.image = UIImage(named: "stellaVuota")
        //stella1.setImage(UIImage(named: "stellaPiena"), for: UIControl.State.selected)
        //stella1.setImage(UIImage(named: "stellaPiena"), for: UIControl.State.focused)
        stella1.setImage(UIImage(named: "stellaPiena"), for: UIControl.State.normal)
        
        votoRecensione = 1
    }
    
    @IBAction func stellaDue(_ sender: Any) {
        stella5.imageView?.image = UIImage(named: "stellaPiena")
        stella2.setImage(UIImage(named: "stellaPiena"), for: UIControl.State.normal)
        stella3.imageView?.image = UIImage(named: "stellaVuota")
        stella4.imageView?.image = UIImage(named: "stellaVuota")
        stella5.imageView?.image = UIImage(named: "stellaVuota")
        votoRecensione = 2
    }
    
    @IBAction func stellaTre(_ sender: Any) {
        stella1.imageView?.image = UIImage(named: "stellaPiena")
        stella2.imageView?.image = UIImage(named: "stellaPiena")
        stella3.setImage(UIImage(named: "stellaPiena"), for: UIControl.State.normal)
        stella4.imageView?.image = UIImage(named: "stellaVuota")
        stella5.imageView?.image = UIImage(named: "stellaVuota")
        votoRecensione = 3
    }
    
    @IBAction func stellaQuattro(_ sender: Any) {
        stella1.imageView?.image = UIImage(named: "stellaPiena")
        stella2.imageView?.image = UIImage(named: "stellaPiena")
        stella3.imageView?.image = UIImage(named: "stellaPiena")
        stella4.setImage(UIImage(named: "stellaPiena"), for: UIControl.State.normal)
        stella5.imageView?.image = UIImage(named: "stellaVuota")
        votoRecensione = 4
    }
    
    @IBAction func stellaCinque(_ sender: Any) {
        stella1.imageView?.image = UIImage(named: "stellaPiena")
        stella2.imageView?.image = UIImage(named: "stellaPiena")
        stella3.imageView?.image = UIImage(named: "stellaPiena")
        stella4.imageView?.image = UIImage(named: "stellaPiena")
        stella5.setImage(UIImage(named: "stellaPiena"), for: UIControl.State.normal)
        votoRecensione = 5
    }
    
    @IBAction func salva(_ sender: Any) {
        if(titoloRecensione.text?.isEmpty == false && nomeUtente.text?.isEmpty == false && descrizioneRecensione.text.isEmpty == false){
            var tmp = Recensione()
            tmp.nomePersona = nomeUtente.text
            tmp.recensionetext = descrizioneRecensione.text
            tmp.titoloRecensione = titoloRecensione.text
            tmp.votoRecensione = self.votoRecensione
            
            dataBaseShared.addRecensione(tagGruppo: tagBand, recensione: tmp)
            _ = navigationController?.popViewController(animated: true)
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
