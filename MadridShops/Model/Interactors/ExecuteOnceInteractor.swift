//
//  ExecuteOnce.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 19/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import Foundation

protocol ExecuteOnceInteractor {
    func execute(closure: () -> Void)
}
