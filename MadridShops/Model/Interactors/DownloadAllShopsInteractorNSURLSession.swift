//
//  DownloadAllShopsInteractorNSURLSession.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 14/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import Foundation

class DownloadAllShopsInteractorNSURLSession: DownloadAllShopsInteractor {
    
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        let urlString = "https://madrid-shops.com/json_new/getShops.php"
        let session = URLSession.shared
        
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                
                OperationQueue.main.addOperation {
                    if error == nil {
                        let shops = parseShops(data: data!)
                        onSuccess(shops)
                    } else {
                        // Comprobamos que nos han pasado una closure de error
                        if let myError = onError {
                            myError(error!)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
