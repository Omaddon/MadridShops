//
//  ShopCell.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 13/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import UIKit

class ShopCell: UICollectionViewCell {
    var shop: Shop?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func refresh(shop: Shop) {
        self.shop = shop
        
        self.label.text = shop.name
        // falta la imageView, ya lo haremos
    }
}
