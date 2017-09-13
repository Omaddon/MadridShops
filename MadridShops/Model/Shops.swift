//
//  Shops.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 9/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import Foundation

public protocol ShopsProtocol {
    func count() -> Int
    func add(shop: Shop)
    func get(index: Int) -> Shop
}

public class Shops: ShopsProtocol {
   private var shopsList: [Shop]?
    
    public init() {
        self.shopsList = []
    }
    
    public func count() -> Int {
        return shopsList?.count ?? 0
    }
    
    public func add(shop: Shop) {
        shopsList?.append(shop)
    }
    
    public func get(index: Int) -> Shop {
        return (shopsList?[index])! 
    }
}
