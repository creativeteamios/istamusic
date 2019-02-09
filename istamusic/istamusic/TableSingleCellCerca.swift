//
//  TableSingleCellCerca.swift
//  istamusic
//
//  Created by Soriano Stefano on 09/02/2019.
//  Copyright © 2019 Creative Team. All rights reserved.
//

import UIKit

class TableSingleCellCerca: UITableViewCell {
    @IBOutlet weak var tumb: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var genderText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
