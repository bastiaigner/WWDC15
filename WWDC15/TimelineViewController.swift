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
    
    var blurEffectView = UIVisualEffectView(effect: UIBlurEffect())
    
    
    let viewControllerIDs = ["2011", "2015"]
    var viewControllers = [UIViewController]()
    
    var contentViews = [UIView]()
    
    func instantiateViewControllers(){
        
        let storyboard = UIStoryboard(name: "TimelineStoryboard", bundle: NSBundle.mainBundle())
        
        for identifier in viewControllerIDs {
            viewControllers.append(storyboard.instantiateViewControllerWithIdentifier(identifier) as! UIViewController)
        }
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    
        instantiateViewControllers()
        
        
        
        
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        
        
        var labelPositions = [CGFloat : String]()
        
        for (index, controller) in enumerate(viewControllers) {
            
            if let title = controller.title {
                labelPositions[CGFloat(index) * screenWidth] = title
            }
            
            
        }
        
        
        
        
        // add content views to
        for (index, controller)in enumerate(viewControllers) {
            
            let contentView = controller.view
            contentView.frame = frameForContentView(atIndex: index, size: self.view.frame.size)
            self.contentViews.append(contentView)
        }
        
        
        
        
        
        
        timelineScrollView.contentSize = CGSize(width: screenWidth * CGFloat(viewControllerIDs.count), height: screenHeight)
        
        blurEffectView.frame = CGRect(origin: CGPointZero, size: timelineScrollView.contentSize)
        //timelineScrollView.addSubview(blurEffectView)
        
        timelineScrollView.backgroundColor = UIColor.blackColor()
        
        timelineScrollView.pagingEnabled = true
        
        
        let correctionOffset = "20".sizeWithAttributes([NSFontAttributeName : UIFont(name: "HelveticaNeue-UltraLight", size: 130)!]).width //  ??
        
        
        let textViews = ParallaxImageSource.generateTextViews([0.5, 0.6, 0.7, 1.4], mainWidth: screenWidth * CGFloat(viewControllerIDs.count), height: screenHeight, texts: labelPositions, leftReadabilityOffset: screenWidth / 2 - correctionOffset)
        
        
        textLayer0 = textViews[0.5]
        textLayer1 = textViews[0.6]
        textLayer2 = textViews[0.7]
        textLayer3 = textViews[1.4]
        
    
        universe = UIImageView(image: UIImage(named: "space"))
        universe.contentMode = UIViewContentMode.ScaleToFill
        universe.frame = CGRect(origin: CGPointZero, size: CGSize(width: screenWidth + screenWidth * 0.15, height: screenHeight))
        
        littleStars = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth + screenWidth * 0.2, height: screenHeight))
        mediumStars = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth + screenWidth * 0.4, height: screenHeight))
        largeStars = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth + screenWidth * 0.55, height: screenHeight))

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

        
        for contentView in contentViews {
            //contentView.backgroundColor = UIColor.whiteColor()
            timelineScrollView.addSubview(contentView)
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func frameForContentView(atIndex index: Int, size: CGSize) -> CGRect {
     
        let fullscreenFrame = CGRect(origin: CGPoint(x: CGFloat(index) * size.width, y: 0), size: size)
        
        return CGRectInset(fullscreenFrame, 300, 200 )
        
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
        
        //littleStars = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth + screenWidth * 0.2, height: screenHeight))
        
        
        let slideIndex = Int(self.timelineScrollView.contentOffset.x / self.view.frame.width)
        
        coordinator.animateAlongsideTransition({ (context) -> Void in
            self.littleStars.frame.size = CGSize(width: size.width + size.width * 0.2, height: size.height)
            self.littleStars.frame.size = CGSize(width: size.width + size.width * 0.4, height: size.height)
            self.littleStars.frame.size = CGSize(width: size.width + size.width * 0.55, height: size.height)
            //self.timelineScrollView.frame.size.height = size.height
            
            self.timelineScrollView.contentSize = CGSize(width: size.width * CGFloat(self.viewControllerIDs.count), height: size.height)
            self.blurEffectView.frame.size = self.timelineScrollView.contentSize
            
            self.timelineScrollView.contentOffset.x = CGFloat(slideIndex) * size.width
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.scrollViewDidScroll(self.timelineScrollView)
            })
            
            
            let correctionOffset = "20".sizeWithAttributes([NSFontAttributeName : UIFont(name: "HelveticaNeue-UltraLight", size: 130)!]).width
            
            
            var labelPositions = [CGFloat : String]()
            
            for (index, controller) in enumerate(self.viewControllers) {
                
                if let title = controller.title {
                    labelPositions[CGFloat(index) * size.width] = title
                }
                
                
            }
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                for (index, contentView) in enumerate(self.contentViews) {
                    
                    contentView.frame = self.frameForContentView(atIndex: index, size: size)
                }
            })
            
            
            // scroll to right position
            
            // FIXME: rotation !
            
            
            //self.timelineScrollView.contentOffset.x = CGFloat(currentSlideIndex) * size.width
            
            
            
            let textViews = ParallaxImageSource.generateTextViews([0.5, 0.6, 0.7, 1.4], mainWidth: size.width * CGFloat(self.viewControllerIDs.count), height: size.height, texts: labelPositions, leftReadabilityOffset: size.width / 2 - correctionOffset)
            
            
            self.textLayer0.removeFromSuperview()
            self.textLayer1.removeFromSuperview()
            self.textLayer2.removeFromSuperview()
            self.textLayer3.removeFromSuperview()
            
            
            
            self.textLayer0 = textViews[0.5]
            self.textLayer1 = textViews[0.6]
            self.textLayer2 = textViews[0.7]
            self.textLayer3 = textViews[1.4]
            
            

            
            
            self.view.addSubview(self.textLayer0)
            self.view.addSubview(self.textLayer1)
            self.view.addSubview(self.textLayer2)
            self.view.addSubview(self.textLayer3)
            
        }, completion: nil)
        
    }

    
    
    func horizontalMotionEffectForLayerAtPositon(percent: Float) -> UIInterpolatingMotionEffect {

        
        var motionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        
        motionEffect.minimumRelativeValue = 60 * percent * -1
        motionEffect.maximumRelativeValue = 60 * percent
        
        
        return motionEffect
        
    }
    

}
