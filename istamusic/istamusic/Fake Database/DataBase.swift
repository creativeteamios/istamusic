//
//  DataBase.swift
//  istamusic
//
//  Created by Soriano Stefano on 10/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import Foundation

let dataBaseShared = Database()

class Database{
    
    let imageBand = ["Alan Walker", "Daft Punk", "Fine Devices", "Ice-Angels 32", "Linkin Park", "Rattatta", "Red Hot Chili Peppers", "Rh Negativo", "Sia", "The Beatles", "Voiceless"]
    var bands : [Band] = []
    
    let generiMusicali = ["House", "French House", "Alternative Rock", "Alternative Rock, Indie Rock", "Alternative Rock, Rap Rock", "Rap, Trap", "Alternative Rock, Funk Rock", "Pop Rock, Pop", "Pop, Indie Pop", "Rock, Beat", "Acoustic Pop" ]
    let locations = [ "Beltiglio","San Marco dei Cavoti","Cervinara","Montesarchio","Sant'Angelo a Cupolo","Cervinara","Cautano","Benevento","Piedimonte Matese","Tocco Caudio","Paolisi"]
    let descrizioni = ["Alan Walker è un disc jockey e produttore discografico norvegese naturalizzato britannico. È diventato noto per il suo brano Faded in collaborazione con la cantante norvegese Iselin Solheim.", "I Daft Punk sono un gruppo musicale francese di musica elettronica fondato dai parigini Guy-Manuel de Homem-Christo e Thomas Bangalter. Il duo è ritenuto uno degli esempi più significativi di ogni tempo nell’ambito della musica elettronica, sia per quanto riguarda il volume di vendite sia per il responso della critica.","I Fine Devices sono una band alternative rock. Il loro singolo di punta è stato Last Night, vendendo 1000 copie.","Gli Ice-Angels 32 sono un duo alternative e indie rock. Attualmente sono a lavoro sul loro primo disco intitolato Calish.","I Linkin Park sono un gruppo musicale statunitense formatosi a Los Angeles nel 1996. Composto fino al 20 luglio 2017 da Chester Bennington, Mike Shinoda, Brad Delson, Phoenix, Rob Bourdon e Joe Hahn, si tratta di uno dei gruppi di maggior successo commerciale degli anni 2000 e 2010, avendo venduto oltre 100 milioni di copie dei loro dischi nel mondo, di cui 70 per gli album.","I Rattatta Music sono un grupo rap/trap.", "I Red Hot Chili Peppers (talvolta abbreviato semplicemente in RHCP o Red Hot) sono un gruppo rock statunitense, formatosi a Los Angeles nel 1983, attualmente composto da Anthony Kiedis (voce), Flea (basso, cori), Josh Klinghoffer (chitarra, cori) e Chad Smith (batteria, percussioni).", "Gli RH Negativo nascono nel gennaio 2015. La band, precedentemente conosciuta con il nome di Area Liga era una tribute band di Luciano Ligabue, ma dopo anni passati a suonare cover di Ligabue decidono di iniziare a comporre brani inediti. Nel 2016 pubblicano il primo disco di inediti intitolato Soffitto Del Mondo.", "Sia Kate Isobelle Furler, nota professionalmente come Sia (Adelaide, 18 dicembre 1975), è una cantautrice, attrice e compositrice australiana; inizialmente nota al grande pubblico per le sue collaborazioni, raggiunge la fama mondiale come solista con il singolo Chandelier.", "The Beatles è stato un gruppo musicale inglese, fondato a Liverpool nel 1960, composto da John Lennon, Paul McCartney, George Harrison e Ringo Starr, e attivo fino al 1970.", "Il progetto elettro-acustico nato in un angolo di conservatorio dove tre ragazzi hanno trovato il giusto compromesso per mettere insieme quello che più gli pareva giusto. Una tromba, una chitarra e un cajon danno il via a quello che, in campo musicale, viene chiamato “acustico” e che letteralmente sta a significare attinente all’udito."  ]
    let followers = [1456,860,445,1232,1192,786,2234,3450,234,1543,192]
    
    let dateEvento = ["07/04/2019", "20/05/2019", "15/03/2019", "27/06/2019", "08/08/2019", "04/06/2019", "09/12/2019", "18/03/2019", "23/11/2019", "07/04/2019", "22/09/2019", "09/06/2019", "28/05/2019", "19/06/2019", "19/02/2019", "24/11/2019", "31/12/2019", "25/05/2019", "15/12/2019", "26/02/2019", "30/08/2019", "25/09/2019"]
    
    let numeriPartecipanti = [3,7,6,32,65,243,5,43,76,83,45,62,67,98,53,25,97,23,65,20,43,56]
    let descrizioniEventi = ["Nuovo appuntamento con la musica live, Spritz e Tapas.", "Solo per questa occasione birre a metà prezzo.", "Siete tutti invitati a questa fantastica serata. Vi aspettiamo.", "Nuova serata di musica live con birra e spritz.", "Live music, beer & food.", "Benevento città spettacolo.", "Sannio Fest Live.", "Granchio Nero cafè live music.", "Spazio Piper Live music.", "Ciarla's Live.", "Sloppy Joe's Irish Pub.", "Opera di Piazzetta Vari.", "Umberto's Pub.","Moe's Beer & Rock.", "Sex, drug and Rock 'n' roll.","Sanremo.", "Festivalbar Pastene Edition.", "Terza sagra della birra e del maialino.", "Pirocca's music.", "Festa patronale del santo patrono.", "Morgana live music.", "San Marco dei Cavoti e i suoi torroncini."]
    
    let nomiPersone = [ "Antonio", "Giuseppe", "Stefano", "Adele", "Umberto", "Davide", "Carmen", "Maria" ]
    let testiRecensioni = ["Mi piace molto questa musica", "Ottima band, bel sound", "Serata fantastica, spero di ritornarci", "Per come era stata sponsorizzata la serata mi aspettavo di meglio", "La band è promettente ma la strumentazione è ancora insufficiente", "E' diventata la mia band preferita", "Bel sound ma cambiate il cantante quanto prima", "Mi piace molto questa band"]
    let votiRecensioni = [4,4,5,2,3,5,3,4]
    let titoliRecensioni = ["Soddisfatto","Grande band","Il massimo!","C'è di meglio","Non il massimo","Il massimo!","Serata ok", "Divertito"]
    let indirizziEventi = ["Benevento", "Avellino"]
    let tag = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    var dateEventoDate = [Date]()
    
    init(){
        inizializza()
    }
    
    //lista eventi
    var eventiaaa = [Evento]()
    func inizializzaEvento(){
        creaArrayDate()
        for index in 0..<11{
            let ev = Evento()
            let ev2 = Evento()
            ev.nomeEvento = "\(imageBand[index]) Live Music"
            ev2.nomeEvento = "\(imageBand[index]) Live Music"
            ev.dataEvento = dateEventoDate[index]
            ev2.dataEvento = dateEventoDate[index+11]
            ev.numeroPartecipanti = numeriPartecipanti[index]
            ev2.numeroPartecipanti = numeriPartecipanti[index+11]
            ev.descrizioneEvento = descrizioniEventi[index]
            ev2.descrizioneEvento = descrizioniEventi[index+11]
            ev.indirizzoEvento = indirizziEventi[0]
            ev2.indirizzoEvento = indirizziEventi[1]
            ev.tagBand = "\(index+1)"
            ev2.tagBand = "\(index+1)"
            eventiaaa.append(ev)
            eventiaaa.append(ev2)
        }
        
        ordinaEventiCrescente()
        
    }
    
    func ordinaEventiCrescente(){
        
        
        for index in 0..<eventiaaa.count{
            for indexb in 0..<eventiaaa.count{
                if(eventiaaa[index].dataEvento?.compare(eventiaaa[indexb].dataEvento!).rawValue == -1){
                    let tmp = eventiaaa[index]
                    eventiaaa[index] = eventiaaa[indexb]
                    eventiaaa[indexb] = tmp
                }
            }
        }
    }
    
    func creaArrayDate(){
        for evento in dateEvento{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyy"
            let tmpData = dateFormatter.date(from: evento)
            dateEventoDate.append(tmpData!)
        }
        
    }
    
    func creaOggettiTipoDate(){
        
    }
    
    
    var recensioniii = [Recensione]()
    func inizializzaRecensione(){
        for index in 0..<8{
            let rec = Recensione()
            rec.nomePersona = nomiPersone[index]
            rec.recensionetext = testiRecensioni[index]
            rec.titoloRecensione = titoliRecensioni[index]
            rec.votoRecensione = votiRecensioni[index]
            
            recensioniii.append(rec)
            
        }
        
        
    }
    
    
    
    
    
    func inizializza(){
        var contatore = 0
        
        inizializzaEvento()
        inizializzaRecensione()
        
        for index in 0..<11{
            let tmp = Band()
            tmp.nomeGruppo = imageBand[index]
            tmp.image = imageBand[index]
            tmp.genereMusicale = generiMusicali[index]
            tmp.location = locations[index]
            tmp.descrizione = descrizioni[index]
            tmp.follower = followers[index]
            tmp.tag = "\(index+1)"
            tmp.eventi.append(eventiaaa[contatore])
            //print(contatore)
            contatore = contatore + 1
            tmp.eventi.append(eventiaaa[contatore])
            contatore = contatore + 1
            //print(recensioniii.count)
            tmp.recensioni.append(recensioniii.randomElement()!)
            tmp.recensioni.append(recensioniii.randomElement()!)
            
            
            
            
            
            
            bands.append(tmp)
        }
    }
    
    
}

/*
 tmp.location = "Corso Garibaldi,\(10+index) Benvento "
 tmp.follower = 100+index
 if(index%2 == 0){
 tmp.descrizione = "una bella descrizione"
 tmp.genereMusicale = "POP, Disco"
 }else{
 tmp.descrizione = "una brutta descrizione"
 tmp.genereMusicale = "Rock, Latino"
 }
 */
