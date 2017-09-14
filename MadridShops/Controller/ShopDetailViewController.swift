//
//  ShopDetailViewController.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 14/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import UIKit

class ShopDetailViewController: UIViewController {

    // Al ponerlo como opcional, no necesitamos init.
    // También podemos hacerlo con ! (unwrap forzado) siempre y cuando no se nos olvide
    // pasar siempre la tienda, sino explota.
    var shop: Shop!
    
    @IBOutlet weak var shopDetailDescription: UITextView!
    @IBOutlet weak var shopImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.shop.name
        self.shopDetailDescription.text = self.shop.description
        self.shop.image.loadImage(into: shopImage)
    }
}
