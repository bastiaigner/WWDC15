//
//  EducationViewController.swift
//  WWDC15
//
//  Created by Bastian Aigner on 4/24/15.
//  Copyright (c) 2015 Bastian Aigner. All rights reserved.
//

import UIKit

class EducationViewController: UIViewController {

    @IBOutlet weak var topTextConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightTextConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
            //adjust layout constaints
            if view.bounds.size.width > view.bounds.height {
                //landscape
                topTextConstraint.constant = 40
                rightTextConstraint.constant = 20
            }
            else {
                //portrait
                topTextConstraint.constant = 210
                rightTextConstraint.constant = 430
            }

        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        
        coordinator.animateAlongsideTransition({ (context) -> Void in
            
            if size.width > size.height {
                //landscape
                self.topTextConstraint.constant = 40
                self.rightTextConstraint.constant = 20
            }
            else {
                //portrait
                
                self.topTextConstraint.constant = 210
                self.rightTextConstraint.constant = 450
            }
            
            
        }, completion: nil)
        
    }


}
