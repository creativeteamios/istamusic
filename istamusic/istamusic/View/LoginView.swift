//
//  Login.swift
//  istamusic
//
//  Created by Soriano Stefano on 08/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit

class LoginView: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func passwordDimenticata(_ sender: Any) {
        //controllo se il campo email non è vuoto e contiene almeno una chiocciola
        if(emailText.text?.isEmpty == false && emailText.text?.contains("@") == true){
            //Se la mail è corretta invio il recupero password via mail
            // TODO: controllare se la mail è presente nel db del server.
            //non è necessario implementare questo metodo.
            let verifica = true
            
            if verifica == true{
                visualizzaErrorCredenzialiAlert(titolo: "Rercupero credenziali",testo: "Email di recupero inviata correttamente.")
            }
            
        }else{
            //se il campo della mail è vuoto compare un alert di campo vuoto
            visualizzaErrorCredenzialiAlert(titolo: "Errore email",testo: "Inserire correttamente la email di recupero.")
        }
    }
    
    @IBAction func login(_ sender: Any) {
        if (emailText.text?.isEmpty == false && passwordText.text?.isEmpty == false){
            //Effettuare Verifica con server
            // TODO: Controllare le credenziali sul server
            
            let verificaServer = true//questa variabile assume il valore in base a cio che restituisce il server ora l'ho impostata su true per provare il funzionamento
            
            if verificaServer == true{
                //se la verifica è giusta bisogna tornare nella schermata home ed aggiornare la scritta login, con il nome del profilo
                // TODO: creare codice per tornare alla schermata principale ed aggiornare login con il nome
            }else{
                //errore credenziali
                visualizzaErrorCredenzialiAlert(titolo: "Errore credenziali",testo: "Le credenziali inserite non sono valide, si prega di controllare e riprovare.")
            }
            
        }else{
            //visualizza un alert per nome o password non inseriti o non corretti
            visualizzaErrorCredenzialiAlert(titolo: "Errore credenziali",testo: "Non Avete compilato tutti i campi correttamente.")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
