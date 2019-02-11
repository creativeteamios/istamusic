//
//  DataBase.swift
//  istamusic
//
//  Created by Soriano Stefano on 10/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import Foundation

class Database{
    
    let imageBand = ["alan walker", "beatles", "daft punk", "elettra", "linkin park", "red hot", "selena", "sia"]
    var bands : [Band] = []
    
    func inizializza(){
        for index in 0..<8{
            let tmp = Band()
            tmp.nomeGruppo = imageBand[index]
            tmp.image = imageBand[index]
            tmp.location = "Corso Garibaldi,\(10+index) Benvento "
            tmp.follower = 100+index
            if(index%2 == 0){
                tmp.descrizione = "una bella descrizione"
                tmp.genereMusicale = "POP, Disco"
            }else{
                tmp.descrizione = "una brutta descrizione"
                tmp.genereMusicale = "Rock, Latino"
            }
            bands.append(tmp)
        }
    }
    

}
