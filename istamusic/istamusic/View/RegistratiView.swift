//
//  Registrati.swift
//  istamusic
//
//  Created by Soriano Stefano on 08/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit
import CoreData

class RegistratiView: UIViewController {
    
    @IBOutlet weak var nometext: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordTextUno: UITextField!
    @IBOutlet weak var passwordTextDue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Codice per far uscire l'icona tonda e aggiungo il margine grigio dello spessore 1
    }
    
    
    @IBAction func registrati(_ sender: Any) {
        
        print("entro nel metodo registrati")
        
        if controlloText(nome: nometext.text!, email: emailText.text!, passwordUno: passwordTextUno.text!, passwordDue: passwordTextDue.text!) == true && passwordTextDue.text == passwordTextUno.text{
            //Aggiungo le credenziali al server e loggo l'utente
            // TODO : Bisgogna registrare l'utente e loggarlo al server
            //connetto i core data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "UtenteRegistrato", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            newUser.setValue(nometext.text, forKey: "nome")
            newUser.setValue(emailText.text, forKey: "username")
            newUser.setValue(passwordTextDue.text, forKey: "password")
            
            do {
                print("PROVO A SALVARE")
                try context.save()
                gestoreUtenteShared.utente.nome = nometext.text
                gestoreUtenteShared.utente.username = emailText.text
                gestoreUtenteShared.utente.password = passwordTextUno.text
        
                visualizzaAlertOk()
            } catch {
                print("Failed saving")
            }
            
        }else{
            visualizzaErrorCredenzialiAlert(titolo: "Errore Compilazione", testo: "Campi non compilati correttamente.")
        }
    }
    
    func visualizzaAlertOk(){
        let alert = UIAlertController(title: "REGISTRAZIONE OK", message: "Registrazione avvenuta con successo", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
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
    }*/
    

}
