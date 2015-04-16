//
//  WelcomeViewController.swift
//  WWDC15
//
//  Created by Bastian Aigner on 12.04.15.
//  Copyright (c) 2015 Bastian Aigner. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, SectionViewController {

    
    var circleLayer = CAShapeLayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        circleLayer.frame = CGRect(x: 150, y: 600, width: 200, height: 200)
        circleLayer.fillColor = UIColor.whiteColor().CGColor
        circleLayer.strokeColor = UIColor.orangeColor().CGColor
        
        
        circleLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 100, height: 100), cornerRadius: 100).CGPath
        
        
        var circleToRectAnimation = CABasicAnimation(keyPath: "path")
        circleToRectAnimation.fromValue = circleLayer.path
        circleToRectAnimation.toValue = UIBezierPath(roundedRect: CGRectMake(0, 0, 180, 180), cornerRadius: 10).CGPath
        circleToRectAnimation.duration = 1.0
        
        circleLayer.addAnimation(circleToRectAnimation, forKey: "circleToRectMorph")
        
        circleLayer.speed = 0.0
        
        (parentViewController as? ViewController)?.view.bringSubviewToFront(self.view)
            view.layer.addSublayer(circleLayer)
    
        self.view.clipsToBounds = false
        
        //
        
    
        
        // Do any additional setup after loading the view.
    } 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didScroll(toPercentage percentage: Float) {
        
        if  0.0 ... 1.0 ~= percentage { // check if percentage is between 0 and 1
            circleLayer.timeOffset = Double(percentage) as CFTimeInterval
        }
        else if percentage < 0 {
            circleLayer.timeOffset = 0.0
        }
        else if percentage > 1 { // should never happen
            circleLayer.timeOffset = 1.0
        }
        
        
    }
    

}
