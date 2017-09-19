//
//  MapShops.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 19/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import Foundation
import CoreData

func mapShopCDIntoShop(shopCD: ShopCD) -> Shop {
    
    let shop: Shop = Shop(name: shopCD.name!)
    
    shop.address = shopCD.address ?? "No address avaible."
    shop.description = shopCD.description_es ?? "No description avaible."
    shop.image = shopCD.image ?? ""
    shop.logo = shopCD.logo ?? ""
    shop.openingHours = shopCD.openingHours ?? ""
    shop.latitude = shopCD.latitude
    shop.longitude = shopCD.longitude
    
    return shop
    
}


func mapShopIntoShopCD(context: NSManagedObjectContext, shop: Shop) -> ShopCD {
    
    let shopCD = ShopCD(context: context)
    
    shopCD.name = shop.name
    shopCD.address = shop.address
    shopCD.description_es = shop.description
    shopCD.image = shop.image
    shopCD.logo = shop.logo
    shopCD.openingHours = shop.openingHours
    shopCD.latitude = shop.latitude ?? 0.0
    shopCD.longitude = shop.longitude ?? 0.0
    
    return shopCD
}
