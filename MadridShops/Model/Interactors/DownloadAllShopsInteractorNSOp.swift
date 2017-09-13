//
//  DownloadAllShopsInteractorNSOp.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 13/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import Foundation

class DownloadAllShopsInteractorNSOp: DownloadAllShopsInteractor {
    
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure = nil) {
        
        let urlString = "https://madrid-shops.com/json_new/getShops.php"
        
        let queue = OperationQueue()
        queue.addOperation {
            
            if let url = URL(string: urlString),
                let data = NSData(contentsOf: url) as Data? {
                do {
                    let jsonObject =
                        try JSONSerialization
                            .jsonObject(with: data,
                                        options: .allowFragments) as! Dictionary<String, Any>
                    let result = jsonObject["result"] as! [Dictionary<String, Any>]
                    
                    let shops = Shops()
                    
                    for shopJson in result {
                        let shop = Shop(name: shopJson["name"]! as! String)
                        shop.adress = shopJson["address"]! as! String
                        shop.name = shopJson["name"] as! String
                        shop.description = shopJson["description_es"] as! String
                        
                        shops.add(shop: shop)
                    }
                    
                    OperationQueue.main.addOperation {
                        onSuccess(shops)
                    }
                    
                } catch {
                    
                }
            }
        }
    }
}
