//
//  String+Image.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 14/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import UIKit

extension String {
    
    func loadImage(into imageView: UIImageView) {
        let queue = OperationQueue()
        queue.addOperation {
            
            if let url = URL(string: self),
                let data = NSData(contentsOf: url),
                let image = UIImage(data: data as Data) {
            
                OperationQueue.main.addOperation {
                    imageView.image = image
                }
            }
        }
    }
    
    // NSURLSession tiene cache, por lo que es mejor en nuestro caso.
    func loadImageNSURLSession(into imageView: UIImageView) {
        let session = URLSession.shared
        
        if let url = URL(string: self) {
            let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error == nil,
                    let image = UIImage(data: data!) {
                    
                    OperationQueue.main.addOperation {
                        imageView.image = image
                    }
                } else {
                    print("Error download image.")
                }
                
            })
            task.resume()
        }
    }
}

