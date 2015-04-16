//
//  TimelineViewController.swift
//  WWDC15
//
//  Created by Bastian Aigner on 05.04.15.
//  Copyright (c) 2015 Bastian Aigner. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var timelineScrollView: UIScrollView!
    
    
    var textLayer0: UIView!
    var textLayer1: UIView!
    var textLayer2: UIView!
    var textLayer3: UIView!
    
    var universe: UIImageView!
    var littleStars: UIView!
    var mediumStars: UIView!
    var largeStars: UIView!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        var size = view.frame.size
        size.width = 1024*5
        timelineScrollView.contentSize = size
        timelineScrollView.backgroundColor = UIColor.blackColor()
        
        timelineScrollView.pagingEnabled = true
        
        
        let correctionOffset = "20".sizeWithAttributes([NSFontAttributeName : UIFont(name: "HelveticaNeue-UltraLight", size: 130)!]).width
        
        
        let textViews = ParallaxImageSource.generateTextViews([0.5, 0.6, 0.7, 1.4], mainWidth: 1024*5, height: 1024, texts: [0: "2011", 1024: "2012", 2048: "2013", 3072: "2014", 4096: "2015"], leftReadabilityOffset: 350)
        
        
        textLayer0 = textViews[0.5]
        textLayer1 = textViews[0.6]
        textLayer2 = textViews[0.7]
        textLayer3 = textViews[1.4]
        
    
        universe = UIImageView(image: UIImage(named: "space"))
        littleStars = UIView(frame: CGRect(x: 0, y: 0, width: size.width + size.width * 0.2, height: size.height))
        mediumStars = UIView(frame: CGRect(x: 0, y: 0, width: size.width + size.width * 0.4, height: size.height))
        largeStars = UIView(frame: CGRect(x: 0, y: 0, width: size.width + size.width * 0.55, height: size.height))

        littleStars.backgroundColor = UIColor(patternImage: UIImage(named: "little-stars")!)
        mediumStars.backgroundColor = UIColor(patternImage: UIImage(named: "medium-stars")!)
        largeStars.backgroundColor = UIColor(patternImage: UIImage(named: "large-stars")!)
        
        
        timelineScrollView.addSubview(universe)
        
        timelineScrollView.addSubview(littleStars)
        
        timelineScrollView.addSubview(mediumStars)
        
        timelineScrollView.addSubview(textLayer0)
        
        timelineScrollView.addSubview(largeStars)
        
        timelineScrollView.addSubview(textLayer1)
        
        timelineScrollView.addSubview(textLayer2)
        
        timelineScrollView.addSubview(textLayer3)
        
        
        
        
        
        textLayer0.addMotionEffect(horizontalMotionEffectForLayerAtPositon(0.5))
        textLayer1.addMotionEffect(horizontalMotionEffectForLayerAtPositon(0.6))
        textLayer2.addMotionEffect(horizontalMotionEffectForLayerAtPositon(0.7))
        textLayer3.addMotionEffect(horizontalMotionEffectForLayerAtPositon(1.4))
        
        littleStars.addMotionEffect(horizontalMotionEffectForLayerAtPositon(0.2))
        mediumStars.addMotionEffect(horizontalMotionEffectForLayerAtPositon(0.4))
        largeStars.addMotionEffect(horizontalMotionEffectForLayerAtPositon(0.55))

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == timelineScrollView {
            
            
            
            textLayer0.frame.origin.x = scrollView.contentOffset.x - scrollView.contentOffset.x * 0.5
            textLayer1.frame.origin.x = scrollView.contentOffset.x - scrollView.contentOffset.x * 0.6
            textLayer2.frame.origin.x = scrollView.contentOffset.x - scrollView.contentOffset.x * 0.7
            textLayer3.frame.origin.x = scrollView.contentOffset.x - scrollView.contentOffset.x * 1.4
            
            universe.frame.origin.x = scrollView.contentOffset.x - scrollView.contentOffset.x * 0.15
            littleStars.frame.origin.x = scrollView.contentOffset.x - scrollView.contentOffset.x * 0.2
            mediumStars.frame.origin.x = scrollView.contentOffset.x - scrollView.contentOffset.x * 0.4
            largeStars.frame.origin.x = scrollView.contentOffset.x - scrollView.contentOffset.x * 0.55
            
            
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        
//        coordinator.animateAlongsideTransition({ (context) -> Void in
//            self.littleStarsView.frame.size.height = size.height
//            self.mediumStarsView.frame.size.height = size.height
//            self.largeStarsView.frame.size.height = size.height
//            self.timelineScrollView.frame.size.height = size.height
//        }, completion: nil)
        
    }

    
    
    func horizontalMotionEffectForLayerAtPositon(percent: Float) -> UIInterpolatingMotionEffect {
//        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc]
//            initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
//        horizontalMotionEffect.minimumRelativeValue = [NSNumber numberWithInt:(arc4random() % 30 * -1)];
//        horizontalMotionEffect.maximumRelativeValue = [NSNumber numberWithInt:(arc4random() % 30)];
//        
//        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc]
//        initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
//        verticalMotionEffect.minimumRelativeValue = [NSNumber numberWithInt:(arc4random() % 30 * -1)];
//        verticalMotionEffect.maximumRelativeValue = [NSNumber numberWithInt:(arc4random() % 30)];
//        
//        UIMotionEffectGroup *backgroundGroup = [UIMotionEffectGroup new];
//        backgroundGroup.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
//        
//        [view addMotionEffect:backgroundGroup];
        
        var motionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        
        motionEffect.minimumRelativeValue = 30 * percent * -1
        motionEffect.maximumRelativeValue = 30 * percent
        
        
        return motionEffect
        
    }
    

}
