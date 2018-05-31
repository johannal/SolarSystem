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
            backgroundView.backgroundColor = presentedObject.averageColor
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let browserViewController = (segue.destination as? UINavigationController)?.viewControllers.first as? WebViewController, segue.identifier == "LearnMore" {
            browserViewController.url = presentedObject?.browserURL
        }
    }
}

class RoundedCornerView : UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = true
        layer.cornerRadius = 12.0
    }
}

extension AstronomicalObject {
    var averageColor: UniversalColor? {
        let baseColorName: Any = name.lowercased().appending("AverageColor")
        let baseColor = UniversalColor(named: baseColorName as! UniversalColorName)
        return baseColor
    }
}
