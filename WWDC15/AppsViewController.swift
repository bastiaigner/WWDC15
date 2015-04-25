//
//  AppsViewController.swift
//  WWDC15
//
//  Created by Bastian Aigner on 4/17/15.
//  Copyright (c) 2015 Bastian Aigner. All rights reserved.
//

import UIKit

class AppsViewController: UIViewController {

    @IBOutlet weak var subsButton: UIButton!
    @IBOutlet weak var eyogaButton: UIButton!
    
    @IBOutlet weak var ipadImageView: UIImageView!
    @IBOutlet weak var iphoneWatchImageView: UIImageView!
    
    
    var selectedButton: Int = 0
    
    
    @IBAction func appSelectValueChanged(sender: UIButton) {
        println(ipadImageView.superview)
        if sender == eyogaButton {
            var constraint = NSLayoutConstraint(item: ipadImageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
            constraint.priority = 900
            self.view.addConstraint(constraint)
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
            
            
            
        }
        else if sender == subsButton {
            
            
            
            
            
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
       
    }
}
