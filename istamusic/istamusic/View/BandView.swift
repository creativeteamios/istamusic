//
//  BandView.swift
//  istamusic
//
//  Created by Soriano Stefano on 13/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit

class BandView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionViewBand: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vista = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCollection", for: indexPath) as! CollectionViewSingleCell
        
        vista.imageCollection.image = UIImage(named: dataBaseShared.bands[indexPath.row].image!)
        vista.imageCollection.layer.borderColor = UIColor.gray.cgColor
        vista.imageCollection.layer.borderWidth = 1
        
        vista.titleCollection.text = dataBaseShared.bands[indexPath.row].nomeGruppo
        vista.descrizioneCollection.text = dataBaseShared.bands[indexPath.row].genereMusicale
        
        return vista
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewBand.delegate = self
        collectionViewBand.dataSource = self
    }
    
    
    //Controllo collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataBaseShared.bands.count
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