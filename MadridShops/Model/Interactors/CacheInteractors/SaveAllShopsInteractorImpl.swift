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
            
            let _ = mapShopIntoShopCD(context: context, shop: shop)
        }
        
        do {
            try context.save()
            onSuccess(shops)
        } catch {
            print("Error mapping Shop into ShopCD - Can't save context.")
        }
    }
}
