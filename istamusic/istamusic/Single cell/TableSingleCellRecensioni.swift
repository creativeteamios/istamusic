//
//  TableSingleCellRecensioni.swift
//  istamusic
//
//  Created by Soriano Stefano on 14/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit

class TableSingleCellRecensioni: UITableViewCell {

    @IBOutlet weak var titoloRecensione: UILabel!
    @IBOutlet weak var immagineRecensione: UIImageView!
    @IBOutlet weak var testoRecensione: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
