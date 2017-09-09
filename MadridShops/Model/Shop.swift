//
//  Shop.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 9/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import Foundation

public class Shop {
    let name:           String
    let description:    String = ""
    let latitude:       Float? = nil
    let longitude:      Float? = nil
    let image:          String = ""
    let logo:           String = ""
    let openingHours:   String = ""
    let adress:         String = ""
    
    public init(name: String) {
        self.name = name
    }
}
