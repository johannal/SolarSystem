//
//  OrbTableViewCell.swift
//  Science
//
//  Created by Sebastian on 08.05.17.
//  Copyright © 2017 Debugger UI. All rights reserved.
//

import UIKit

class OrbTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orbNameLabel: UILabel!
    @IBOutlet weak var orbGravityLabel: UILabel!
    @IBOutlet weak var orbDiameterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
