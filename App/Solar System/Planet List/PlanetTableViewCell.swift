//
//  PlanetTableViewCell.swift
//  Solar System iOS
//
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {

    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var planetDescriptionLabel: UILabel!
    @IBOutlet weak var planetImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
