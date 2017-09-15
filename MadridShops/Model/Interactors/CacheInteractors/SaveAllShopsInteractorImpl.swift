//
//  SaveAllShopsInteractorImpl.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 15/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import Foundation
import CoreData

class SaveAllShopsInteractorImpl: SaveAllShopsInteractor {
    
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void) {
        execute(shops: shops,
                context: context,
                onSuccess: onSuccess,
                onError: nil)
    }
    
    
    func execute(shops: Shops,
                 context: NSManagedObjectContext,
                 onSuccess: @escaping (Shops) -> Void,
                 onError: errorClosure) {
        
        for i in 0 ..< shops.count() {
            let shop = shops.get(index: i)
            
            // mapping Shop into ShopCD
            let shopCD = ShopCD(context: context)
            shopCD.name = shop.name
            shopCD.address = shop.adress
            shopCD.description_es = shop.description
            shopCD.image = shop.image
            shopCD.logo = shop.logo
            // shopCD.latitude = shop.latitude!
            // shopCD.longitude = shop.longitude!
            shopCD.openingHours = shop.openingHours
        }
        
        do {
            try context.save()
            onSuccess(shops)
        } catch {
            print("Error mapping Shop into ShopCD - Can't save context.")
        }
    }
}
