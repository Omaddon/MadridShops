//
//  SetExecutedOnceInteractorImp.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 19/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import Foundation

class SetExecutedOnceInteractorImp: SetExecutedOnceInteractor {
    func execute() {
        let defaults = UserDefaults.standard
        
        defaults.set("SAVED", forKey: "once")
        
        defaults.synchronize()
    }
}
