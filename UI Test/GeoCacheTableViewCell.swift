//
//  GeoCacheTableViewCell.swift
//  UI Test
//
//  Created by Ethan Lo on 11/13/17.
//  Copyright © 2017 EthanLo. All rights reserved.
//

import UIKit

class GeoCacheTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var Title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
