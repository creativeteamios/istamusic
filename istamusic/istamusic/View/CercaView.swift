//
//  Cerca.swift
//  istamusic
//
//  Created by Soriano Stefano on 09/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit

class CercaView: UITableViewController, UISearchResultsUpdating {
    
    var searchController: UISearchController!
    var searchResult = [Band]()
    var dataBase = Database()
    
    
    //aggiorna i risulati della ricerca
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            //testo cercato
            print(searchText)
            
            //codice per filtrare il cerca
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContent(for searchText: String ){
        
        searchResult = dataBase.bands.filter({(band) -> Bool in
            if(band.nomeGruppo?.localizedCaseInsensitiveContains(searchText) == true || band.genereMusicale?.localizedCaseInsensitiveContains(searchText) == true ||
                band.location?.localizedCaseInsensitiveContains(searchText) == true){
                //print("\(searchText) \(band.nomeGruppo!) \(band.genereMusicale)")
                return true
            }
            return false
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        //carico il Db
        dataBase.inizializza()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        // la funzione che si opccupa di fare la ricerca sta nel controller
        searchController.searchResultsUpdater = self
        //con questo nessuno può modificare i dati prensenti nella tabella
        searchController.dimsBackgroundDuringPresentation = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive{
            return searchResult.count
        }else{
            return dataBase.bands.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCellCerca", for: indexPath) as! TableSingleCellCerca
        
        var band = (searchController.isActive) ? searchResult[indexPath.row] : dataBase.bands[indexPath.row]
        
        // Configure the cell..
        cell.titleText.text = band.nomeGruppo
        cell.descriptionText.text = band.descrizione
        cell.genderText.text = band.genereMusicale
        cell.tumb.image = UIImage(named: band.image!)
        cell.tumb.layer.cornerRadius = cell.tumb.frame.size.width / 2
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
