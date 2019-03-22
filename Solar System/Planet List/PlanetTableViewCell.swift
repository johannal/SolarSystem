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
    @IBOutlet weak var tintBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(withObject object: AstronomicalObject) {
        planetNameLabel.text = object.name
        planetDescriptionLabel.text = object.description
        planetImageView.image = object.globeImage
        tintBackgroundView?.backgroundColor = object.averageColor
    }

}
