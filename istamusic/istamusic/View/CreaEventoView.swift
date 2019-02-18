//
//  CreaEventoView.swift
//  istamusic
//
//  Created by Soriano Stefano on 15/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit

class CreaEventoView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nomeEvento: UITextField!
    @IBOutlet weak var dataEvento: UITextField!
    @IBOutlet weak var luogoEvento: UITextField!
    @IBOutlet weak var descrizioneEvento: UITextView!
    @IBOutlet weak var bandPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bandPicker.delegate = self
        bandPicker.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func salva(_ sender: Any) {
        if(checkField()){
            let tmp = Evento()
            let pos = bandPicker.selectedRow(inComponent: 0)
            
            let tag = dataBaseShared.bands[pos].tag
            
            tmp.tagBand = tag
            tmp.dataEvento = convertiData(data: dataEvento.text!)
            tmp.nomeEvento = nomeEvento.text
            tmp.indirizzoEvento = luogoEvento.text
            tmp.descrizioneEvento = descrizioneEvento.text
            tmp.numeroPartecipanti = 0
            
            dataBaseShared.aggiungiEvento(tag: tag!, evento: tmp)
            dataBaseShared.ordinaEventiCrescente()
            
            _ = navigationController?.popViewController(animated: true)
            
        }else{
            visualizzaErrorCredenzialiAlert(titolo: "Errore Campi", testo: "Completare correttamente tutti i campi")
        }
    }
    
    func convertiData(data : String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy"
        return dateFormatter.date(from: data)!
    }
    
    func visualizzaErrorCredenzialiAlert(titolo: String, testo: String){
        let alert = UIAlertController(title: titolo, message: testo, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkField()-> Bool{
        if(nomeEvento.text?.isEmpty == false && dataEvento.text?.isEmpty == false && luogoEvento.text?.isEmpty == false && descrizioneEvento.text.isEmpty == false){
            return true
        }
        return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataBaseShared.bands.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataBaseShared.bands[row].nomeGruppo
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
