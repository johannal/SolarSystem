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
            
            //
            let baseColorName: Any = presentedObject.name.lowercased().appending("BaseColor")
            let baseColor = UniversalColor(named: baseColorName as! UniversalColorName)
            backgroundView.backgroundColor = baseColor
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
