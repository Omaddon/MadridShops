//
//  ViewController.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 9/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var shops: Shops?
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorFakeImpl()
        /*
        downloadShopsInteractor.execute(onSuccess: { (shops: Shops) in
            // OK
        }) { (error: Error) in
            // ERROR
        }
         */
        
        // O podemos escribirlo así
        downloadShopsInteractor.execute { (shops: Shops) in
            //print("Name: " + shops.get(index: 0).name)
            self.shops = shops
            
            self.shopsCollectionView.delegate = self
            self.shopsCollectionView.dataSource = self
        }
    }
}

