//
//  PlanetDetailsViewController.swift
//  Solar System iOS
//
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class PlanetDetailsViewController: UIViewController {
    
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var planetDescriptionLabel: UILabel!
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    var presentedObject: AstronomicalObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let presentedObject = presentedObject {
            planetNameLabel.text = presentedObject.name
            planetDescriptionLabel.text = presentedObject.description
            planetImageView.image = presentedObject.globeImage
            
            // Tint background view with object base color
            let baseColorName: Any = presentedObject.name.lowercased().appending("AverageColor")
            let baseColor = UniversalColor(named: baseColorName as! UniversalColorName)
            backgroundView.backgroundColor = baseColor
        }
    }
    
    @IBAction func addToFavoritesButtonPressed(sender: Any) {
        presentedObject?.addToFavorites()
        let message = "\(presentedObject!.name) was successfully added to your favorites."
        let alert = UIAlertController(title: "Added to Favorites", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    // Allow sharing the planets description
    @IBAction func shareButtonPressed(sender: Any) {
        let items = [presentedObject!.description]
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller.modalPresentationStyle = .popover
        present(controller, animated: true, completion: nil)
    }
}
