//
//  TableSingleCellEventi.swift
//  istamusic
//
//  Created by Soriano Stefano on 11/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit

class TableSingleCellEventi: UITableViewCell {

    @IBOutlet weak var imageEvento: UIImageView!
    @IBOutlet weak var titleEvento: UILabel!
    @IBOutlet weak var subTitleEvento: UILabel!
    @IBOutlet weak var genereEvento: UILabel!
    @IBOutlet weak var imageMese: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
