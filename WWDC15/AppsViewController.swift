//
//  AppsViewController.swift
//  WWDC15
//
//  Created by Bastian Aigner on 4/17/15.
//  Copyright (c) 2015 Bastian Aigner. All rights reserved.
//

import UIKit

class AppsViewController: UIViewController {

    @IBOutlet weak var subsIcon: UIImageView!
    @IBOutlet weak var eyogaIcon: UIImageView!
    
    override func viewDidLoad() {
        subsIcon.layer.cornerRadius = 12
        eyogaIcon.layer.cornerRadius = 12
        
        subsIcon.clipsToBounds = true
        eyogaIcon.clipsToBounds = true
    }
    
    
}
