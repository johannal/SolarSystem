//
//  Navigator.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import AppKit

class SolarSystemPlanetsDataSource: NSObject, NSCollectionViewDataSource, NSCollectionViewDelegate {

    var planetDetails: [Dictionary<String, Any>]?

    var numberOfPlanets: Int {
        return planetDetails?.count ?? 0
    }
    
    override init() {
        super.init()
        setup()
    }
    
    func setup() {
        // TODO: Pull out into actual model that backs the 3D scene and the collection view
        let planetInfoPath = Bundle.main.path(forResource: "PlanetDetails", ofType: "plist")!
        planetDetails = NSArray.init(contentsOfFile: planetInfoPath) as? [Dictionary<String, Any>]
    }
    
    // MARK: - NSCollectionViewDataSource
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPlanets
    }
    
    public func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let identifier = NSUserInterfaceItemIdentifier(rawValue: "AstronomicalObjectViewItem")
        let item = collectionView.makeItem(withIdentifier: identifier, for: indexPath)
        guard let collectionViewItem = item as? AstronomicalObjectViewItem else {return item}
        
        if let name = planetDetails?[indexPath.item]["name"] as? String {
            collectionViewItem.textField?.stringValue = name
            collectionViewItem.imageView?.image = NSImage(named: NSImage.Name(rawValue: "\(name)Globe"))
        }
        
        return item
    }
}
