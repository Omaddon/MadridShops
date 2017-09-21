//
//  ViewController.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 9/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var context: NSManagedObjectContext!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        self.map.delegate = self
        
        ExecuteOnceInteractorImpl().execute {
            initializeData()
        }
        
        // Debemos esperar a que termine de cargar los datos para preguntar
        // por los datos, pues usamos CoreData para la la CollectionView
        self.shopsCollectionView.delegate = self
        self.shopsCollectionView.dataSource = self
        
        
        let madridLocation = CLLocation(latitude: 40.41889,
                                         longitude: -3.69194)
        //self.map.setCenter(madridLocation.coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: madridLocation.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.map.setRegion(region, animated: true)
    }
    
    
    func initializeData() {
        // Elegimos el interactor que queramos usar (el fake, NSOp, NSURLSession, etc)
        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSURLSession()
        
        downloadShopsInteractor.execute { (shops: Shops) in

            let cacheInteractor = SaveAllShopsInteractorImpl()
            cacheInteractor.execute(shops: shops,
                                    context: self.context,
                                    onSuccess: { (shops: Shops) in
                // Ha terminado de bajar los datos y mapearlos a nuesta DB
                // Lo marcamos en las UserDefaults para no volver a bajarlo
                SetExecutedOnceInteractorImp().execute()
                
                // Como esto se hace en otro hilo, la primera vez que se bajan los datos
                // se establece el delegate y el dataSource antes de tener datos (line 33)
                // Para solucionarlo, reasignamos el delegate y el dataSource y forzamos
                // la regarca de los datos de la CollectionView.
                // Invalidamos el _fetchedResultsController para indicarle que tiene que
                // que volver a hacer un request a la DB tras guardar los datos.
                self._fetchedResultsController = nil
                self.shopsCollectionView.delegate = self
                self.shopsCollectionView.dataSource = self
                self.shopsCollectionView.reloadData()
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shop: ShopCD = self.fetchedResultsController.object(at: indexPath)
        
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
            let shopCD: ShopCD = sender as! ShopCD
            vc.shop = mapShopCDIntoShop(shopCD: shopCD)
        }
    }
    
    // MARK: - Fetched results controller
    
    var _fetchedResultsController: NSFetchedResultsController<ShopCD>? = nil
    
    
    var fetchedResultsController: NSFetchedResultsController<ShopCD> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ShopCD> = ShopCD.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        // fetchRequest == SELECT * FROM EVENT ORDER BY TIMESTAMP DESC
        _fetchedResultsController =
            NSFetchedResultsController(fetchRequest: fetchRequest,
                                       managedObjectContext: self.context!,
                                       sectionNameKeyPath: nil,
                                       cacheName: "ShopCacheFile")
        // _fetchedResultsController = self
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.map.setCenter(location.coordinate, animated: true)
    }
    
    
    func loadAnnotation(_ shopCD: ShopCD) {
        let shopLocation = CLLocation(latitude: CLLocationDegrees(shopCD.latitude),
                                      longitude: CLLocationDegrees(shopCD.longitude))
        
        let annotation = Annotation(coordinate: shopLocation.coordinate,
                                    title: shopCD.name,
                                    subtitle: shopCD.openingHours)
        
        self.map.addAnnotation(annotation)
    }
    
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        if let shops = self.fetchedResultsController.fetchedObjects {
            for shopCD in shops {
                loadAnnotation(shopCD)
            }
        }
    }
}

