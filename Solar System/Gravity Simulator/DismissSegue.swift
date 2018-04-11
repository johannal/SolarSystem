//
//  DismissSegue.swift
//  Solar System
//
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class DismissSegue: UIStoryboardSegue {
    
    override func perform() {
        source.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
