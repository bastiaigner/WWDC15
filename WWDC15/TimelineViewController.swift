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
    
    
    let spaceImageView = UIImageView(image: UIImage(named: "space"))
    let littleStarsView = UIView(frame: CGRectMake(-70, 0, 5000, 768))
    let mediumStarsView = UIView(frame: CGRectMake(-70, 0, 5000, 768))
    let largeStarsView = UIView(frame: CGRectMake(-70, 0, 5000, 768))

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        var size = view.frame.size
        size.width = 5000
        timelineScrollView.contentSize = size
        timelineScrollView.backgroundColor = UIColor.orangeColor()
        
        
        spaceImageView.frame.origin.x = -70
        
        littleStarsView.backgroundColor = UIColor(patternImage: UIImage(named: "little-stars")!)
        mediumStarsView.backgroundColor = UIColor(patternImage: UIImage(named: "medium-stars")!)
        largeStarsView.backgroundColor = UIColor(patternImage: UIImage(named: "large-stars")!)
        
        
        timelineScrollView.addSubview(spaceImageView)
        timelineScrollView.addSubview(littleStarsView)
        timelineScrollView.addSubview(mediumStarsView)
        timelineScrollView.addSubview(largeStarsView)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == timelineScrollView {
            //spaceScrollView.contentOffset.x = scrollView.contentOffset.x * 0.5
            
            spaceImageView.frame.origin.x = scrollView.contentOffset.x * 0.93 - 70
            littleStarsView.frame.origin.x = scrollView.contentOffset.x * 0.89 - 70
            mediumStarsView.frame.origin.x = scrollView.contentOffset.x * 0.82 - 70
            largeStarsView.frame.origin.x = scrollView.contentOffset.x * 0.7 - 70
            
        }
    }
    
    

}
