//
//  Registrati.swift
//  istamusic
//
//  Created by Soriano Stefano on 08/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit

class Registrati: UIViewController {
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nometext: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordTextUno: UITextField!
    @IBOutlet weak var passwordtextDue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Codice per far uscire l'icona tonda e aggiungo il margine grigio dello spessore 1
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width / 2
        imageProfile.layer.borderColor = UIColor.gray.cgColor
        imageProfile.layer.borderWidth = 1
        
    }
    
    @IBAction func addPic(_ sender: Any) {
        //Inserire il codice per scattare una foto e metterla come immagine di profilo
        // TODO : Codice per scattare foto, salvarla nella memoria dell'app
    }
    
    @IBAction func registrati(_ sender: Any) {
        if controlloText(nome: nometext.text!, email: emailText.text!, passwordUno: passwordTextUno.text!, passwordDue: passwordtextDue.text!) == true{
            //Aggiungo le credenziali al server e loggo l'utente
            // TODO : Bisgogna registrare l'utente e loggarlo al server
            
        }else{
            visualizzaErrorCredenzialiAlert(titolo: "Errore Compilazione", testo: "Campi non compilati correttamente.")
        }
    }
    
    @IBAction func annulla(_ sender: Any) {
        //bottone per toranre alla view precedente
        _ = navigationController?.popViewController(animated: true)
    }    
    
    func visualizzaErrorCredenzialiAlert(titolo: String, testo: String){
        let alert = UIAlertController(title: titolo, message: testo, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func controlloText(nome: String, email: String, passwordUno: String, passwordDue: String) -> Bool{
        //controllo che tutti i campi siano correttamente formati
        if(nome.isEmpty == false && email.isEmpty == false && email.contains("@") == true && passwordUno.isEmpty == false && passwordDue.isEmpty == false && (passwordUno == passwordDue)){
                return true
            }
        return false
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
