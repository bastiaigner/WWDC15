//
//  WelcomeViewController.swift
//  WWDC15
//
//  Created by Bastian Aigner on 12.04.15.
//  Copyright (c) 2015 Bastian Aigner. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, SectionViewController {

    

    
    @IBOutlet var introLabels: [UILabel]!
    var animator = UIDynamicAnimator()
    
    var userDidUnderstandScrollingBehavior = false // set to true once the user did scroll
    var dynamicsTimer: NSTimer!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide labels
        for label in introLabels {
            label.alpha = 0
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        // show labels
        UIView.animateKeyframesWithDuration(3.0, delay: 0, options: nil, animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.333333, animations: { () -> Void in
                self.introLabels[0].alpha = 1
            })
            UIView.addKeyframeWithRelativeStartTime(0.333333, relativeDuration: 0.222222, animations: { () -> Void in
                self.introLabels[1].alpha = 1
            })
            UIView.addKeyframeWithRelativeStartTime(0.555555, relativeDuration: 0.222222, animations: { () -> Void in
                self.introLabels[2].alpha = 1
            })
            UIView.addKeyframeWithRelativeStartTime(0.777777, relativeDuration: 0.222222, animations: { () -> Void in
                self.introLabels[3].alpha = 1
            })
            
        }) { (finished) in
                // completion
            
        
        }
        
        
        self.dynamicsTimer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("bump"), userInfo: nil, repeats: true)
        
        
    }
    
    
    
    func bump() {
        
        self.animator.removeAllBehaviors()
        
        let item = DynamicHub()
        
        let pushBehavior = UIPushBehavior(items: [item], mode: .Instantaneous)
        pushBehavior.pushDirection = CGVector(dx: 0, dy: 2.8)
        let gravity = UIGravityBehavior(items: [item])
        gravity.gravityDirection = CGVector(dx: 0, dy: -1)
        let collision = UICollisionBehavior(items: [item])
        collision.collisionMode = UICollisionBehaviorMode.Boundaries
        collision.addBoundaryWithIdentifier("bottom", fromPoint: CGPoint(x: 0, y: -50.7), toPoint: CGPoint(x: 1000, y: -50.7))
        
        let dynamicItemBehavior = UIDynamicItemBehavior(items: [item])
        dynamicItemBehavior.elasticity = 0.6
        dynamicItemBehavior.resistance = 0.65
        dynamicItemBehavior.allowsRotation = false
        gravity.action = {
            if !pushBehavior.active {
                self.animator.removeBehavior(pushBehavior)
            }
            if self.userDidUnderstandScrollingBehavior {
                self.animator.removeAllBehaviors()
                self.dynamicsTimer.invalidate()
                return
            }
            
            var scrollView = (self.parentViewController as! ViewController).scrollView
            
            
            // we cant just update the contentOffset as the delegate would than be called
            var scrollBounds = scrollView.bounds
            scrollBounds.origin.y = item.center.y
            scrollView.bounds = scrollBounds
            
            
            return
        }
        self.animator.addBehavior(gravity)
        self.animator.addBehavior(collision)
        self.animator.addBehavior(dynamicItemBehavior)
        self.animator.addBehavior(pushBehavior)

        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            self.animator.removeAllBehaviors()
        }
        

        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    func didScroll(toPercentage percentage: Float) {
        
        if !userDidUnderstandScrollingBehavior {
            if percentage > 0.1 {
                userDidUnderstandScrollingBehavior = true
            }
            else {
                //userDidUnderstandScrollingBehavior = true
                self.animator.removeAllBehaviors()
            }
            
        }
        
    }
    
    // has to be implemented
    func didFinishScrollingToSlide(#fromBottom: Bool) {
        
    }
    

}





// UIDynamicItem helper class
class DynamicHub : NSObject, UIDynamicItem {
    var center: CGPoint
    var bounds: CGRect
    var transform: CGAffineTransform
    
    override init() {
        center = CGPoint(x: 0, y: 0)
        bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        transform = CGAffineTransform()
    }
}




















