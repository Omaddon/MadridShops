//
//  DownloadAllShopsInteractorFakeImpl.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 13/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import Foundation

class DownloadAllShopsInteractorFakeImpl: DownloadAllShopsInteractor {
    
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure = nil) {
        let shops = Shops()
        
        for i in 0...10 {
            let shop = Shop(name: "Shop number \(i)")
            shop.adress = "Adress \(i)"
            
            shops.add(shop: shop)
        }
        
        OperationQueue.main.addOperation {
            onSuccess(shops)
        }
    }
}
