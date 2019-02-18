//
//  GestoreUtente.swift
//  istamusic
//
//  Created by Soriano Stefano on 17/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import Foundation

let gestoreUtenteShared = GestoreUtente()

class GestoreUtente{
    var utente = Utente()
    
    func registrato()->Bool{
        if(utente.username?.isEmpty == false){
            return true
        }
        return false
    }
    
    func controlloCredenziali(username : String, password : String)->Bool{
        if(username == "giuseppe@libero.it" && password == "vegano"){
            utente.nome = "giuseppe"
            utente.username = username
            utente.password = password
            
            return true
        }
        if(username == utente.username && password == utente.password){
            return true
        }
        return false
    }
    
    
}
