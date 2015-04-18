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
    
    
    @IBOutlet weak var appleWatchImageView: UIImageView!
    @IBOutlet weak var iphoneImageView: UIImageView!
    @IBOutlet weak var ipadImageView: UIImageView!
    
    
    var selectedButton: Int = 0
    
    
    @IBAction func appSelectValueChanged(sender: UIButton) {
        
        if sender == eyogaButton {

            eyogaButton.layer.borderWidth = 2
            subsButton.layer.borderWidth = 0
            selectedButton = 1
            
            ipadImageView.hidden = false
            iphoneImageView.hidden = true
            appleWatchImageView.hidden = true
            
            
        }
        else if sender == subsButton {
            
            
            self.eyogaButton.layer.borderWidth = 0
            self.subsButton.layer.borderWidth = 2
            self.selectedButton = 0
            
            ipadImageView.hidden = true
            iphoneImageView.hidden = false
            appleWatchImageView.hidden = false
            
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        subsButton.layer.cornerRadius = 12
        subsButton.layer.borderColor = UIColor(red: 237/255, green: 206/255, blue: 55/255, alpha: 1).CGColor
        subsButton.layer.masksToBounds = true
        
        eyogaButton.layer.cornerRadius = 12
        eyogaButton.layer.borderColor = UIColor(red: 237/255, green: 206/255, blue: 55/255, alpha: 1).CGColor
        eyogaButton.layer.masksToBounds = true
        
        
        subsButton.layer.borderWidth = 2
        selectedButton = 0
    }
}
