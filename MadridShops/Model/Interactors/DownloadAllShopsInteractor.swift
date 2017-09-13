//
//  DownloadAllShopsInteractor.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 13/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import Foundation

// typealias errorClosure = ((Error) -> Void)?

protocol DownloadAllShopsInteractor {
    
    func execute(onSuccess: @escaping (Shops) -> Void,
                 onError: errorClosure)
    func execute(onSuccess: @escaping (Shops) -> Void)
}
