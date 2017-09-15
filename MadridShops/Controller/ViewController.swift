//
//  ViewController.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 9/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var shops: Shops?
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Elegimos el interactor que queramos usar (el fake, NSOp, NSURLSession, etc)
        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSURLSession()

        downloadShopsInteractor.execute { (shops: Shops) in
            //print("Name: " + shops.get(index: 0).name)
            self.shops = shops
            
            self.shopsCollectionView.delegate = self
            self.shopsCollectionView.dataSource = self
            
            let cacheInteractor = SaveAllShopsInteractorImpl()
            cacheInteractor.execute(shops: shops,
                                    context: self.context,
                                    onSuccess: { (shops: Shops) in
                                        
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shop = self.shops?.get(index: indexPath.row)
        
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shop)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopDetailSegue" {
            let vc = segue.destination as! ShopDetailViewController
            
            // Podemos sacar la Shop del sender porque con el didSelectItemAt se lo mandamos
            // Si NO usamos el Segue de "Todo el View Controller", ie, si lo hacemos a mano,
            // tendríamos que seguir usando el vc.shop = shop pues no la tendríamos en el sender.

            //let indexpath = shopsCollectionView.indexPathsForSelectedItems![0]
            //let shop = self.shops?.get(index: indexpath.row)
            //vc.shop = shop
            vc.shop = sender as! Shop
        }
    }
}

