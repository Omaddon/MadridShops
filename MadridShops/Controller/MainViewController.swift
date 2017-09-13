//
//  MainViewController.swift
//  MadridShops
//
//  Created by MIGUEL JARDÓN PEINADO on 13/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import UIKit
import FillableLoaders

class MainViewController: UIViewController {

    var myLoader: WavesLoader?
    
    @IBOutlet weak var redRectangle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //// Star Drawing
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x: 180, y: 25))
        starPath.addLine(to: CGPoint(x: 195.16, y: 43.53))
        starPath.addLine(to: CGPoint(x: 220.9, y: 49.88))
        starPath.addLine(to: CGPoint(x: 204.54, y: 67.67))
        starPath.addLine(to: CGPoint(x: 205.27, y: 90.12))
        starPath.addLine(to: CGPoint(x: 180, y: 82.6))
        starPath.addLine(to: CGPoint(x: 154.73, y: 90.12))
        starPath.addLine(to: CGPoint(x: 155.46, y: 67.67))
        starPath.addLine(to: CGPoint(x: 139.1, y: 49.88))
        starPath.addLine(to: CGPoint(x: 164.84, y: 43.53))
        starPath.close()
        starPath.fill()
        
        let myPath = starPath.cgPath
        self.myLoader = WavesLoader.showLoader(with: myPath)
        self.view.addSubview(self.myLoader!)
        
        let rect = CGRect(x: 10, y: 100, width: 200, height: 200)
        let v = UIView(frame: rect)
        v.backgroundColor = UIColor.blue
        self.view.addSubview(v)
        
        // gesture TAP
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateView))
        tapGesture.numberOfTouchesRequired = 1  // números de dedos requeridos para el tap
        tapGesture.numberOfTapsRequired = 2     // número de golpes para el tap
        self.view.addGestureRecognizer(tapGesture)
        
        // gesture SWIPE
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(restoreView))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    @objc func animateView() {
        UIView.animate(withDuration: 2.0) {
            if let v = self.myLoader {
                let newFrame = CGRect(x: v.frame.origin.x,
                                      y: v.frame.origin.y + 200,
                                      width: v.frame.size.width,
                                      height: v.frame.size.height)
                v.frame = newFrame
            }
            
            self.redRectangle.layer.cornerRadius = self.redRectangle.layer.cornerRadius + 10
            self.redRectangle.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        }
    }
    
    @objc func restoreView() {
        UIView.animate(withDuration: 2.0, animations: {
            if let v = self.myLoader {
                let newFrame = CGRect(x: 0,
                                      y: 0,
                                      width: v.frame.size.width,
                                      height: v.frame.size.height)
                v.frame = newFrame
            }
        }) { (stop: Bool) in
            
            UIView.animate(withDuration: 2.0, animations: {
                self.redRectangle.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.redRectangle.layer.cornerRadius = 0
            })
        }
    }
}
