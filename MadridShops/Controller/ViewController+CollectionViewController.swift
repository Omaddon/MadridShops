//
//  ViewController+CollectionViewController.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 13/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if let shops = self.shops {
            return shops.count()
        }
        return 0
        // return shops.count() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ShopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell",
                                                                for: indexPath) as! ShopCell
        
        let shop: Shop = (self.shops?.get(index: indexPath.row))!
        cell.refresh(shop: shop)
        
        return cell
    }
}
