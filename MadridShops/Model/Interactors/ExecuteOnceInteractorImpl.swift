//
//  ExecuteOnceInteractorImpl.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 19/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import Foundation

class ExecuteOnceInteractorImpl: ExecuteOnceInteractor {
    func execute(closure: () -> Void) {
        let defaults = UserDefaults.standard
        
        if let _ = defaults.string(forKey: "once") {
            // Hay contenido en la clave, es decir, ya hemos bajado los datos antes
        } else {
            // No hemos guardado nunca, primera vez en descargar los datos
            closure()
        }
    }
}
