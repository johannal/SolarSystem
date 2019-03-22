//
//  AstronomicalObjectViewItem.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Cocoa

class AstronomicalObjectViewItem: NSCollectionViewItem {
    
    @IBOutlet weak var backgroundBox: NSBox?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundBox?.alphaValue = 0.2
    }
    
}
