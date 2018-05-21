//
//  NetworkModel.swift
//  Solar System iOS
//
//  Created by Kacper Harasim on 5/21/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

struct Planet {
    let name: String
}

struct Moon {
    let name: String
    let planet: Planet
}
