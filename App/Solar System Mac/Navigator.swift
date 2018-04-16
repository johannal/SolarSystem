//
//  Navigator.swift
//  Solar System Mac
//
//  Created by Sebastian Fischer on 14.04.18.
//  Copyright © 2018 Apple. All rights reserved.
//

import AppKit

class Navigator: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    var planetDetails: [Dictionary<String, Any>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Pull out into actual model that backs the 3D scene and the collection view
        let planetInfoPath = Bundle.main.path(forResource: "PlanetDetails", ofType: "plist")!
        planetDetails = NSArray.init(contentsOfFile: planetInfoPath) as? [Dictionary<String, Any>]
    }
    
    
    // MARK: - NSCollectionViewDataSource
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return planetDetails?.count ?? 0
    }
    
    public func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let identifier = NSUserInterfaceItemIdentifier(rawValue: "AstronomicalObjectViewItem")
        let item = collectionView.makeItem(withIdentifier: identifier, for: indexPath)
        guard let collectionViewItem = item as? AstronomicalObjectViewItem else {return item}
        
        
        if let name = planetDetails?[indexPath.item]["name"] as? String {
            collectionViewItem.textField?.stringValue = name
            
            collectionViewItem.imageView?.image = NSImage(named: NSImage.Name(rawValue: "\(name)Globe"))
        }
            
        //        let diameter = planetInfo["diameter"] as! Double
        //        let orbitalRadius = planetInfo["orbitalRadius"] as! Double
        
        return item
    }

    
}
