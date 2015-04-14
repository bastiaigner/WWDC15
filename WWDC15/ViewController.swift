//
//  ViewController.swift
//  WWDC15
//
//  Created by Bastian Aigner on 26.03.15.
//  Copyright (c) 2015 Bastian Aigner. All rights reserved.
//


@objc protocol SectionViewController {
    optional func didScroll(toPercentage percentage: Float)
}




import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    
    
    var viewControllers: [UIViewController]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = instantiateViewControllers()
        setContentSize()
        
        populateScrollViewWithViewControllers()
        
        
        scrollView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        
        let currentSlideIndex = Int(scrollView.contentOffset.y / scrollView.bounds.size.height)
        
        coordinator.animateAlongsideTransition({ (context) -> Void in
            
            
            var contentSize = size
            contentSize.height = CGFloat(size.height) * CGFloat(self.viewControllers.count)
            self.scrollView.contentSize = contentSize
        
            
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: CGFloat(currentSlideIndex) * size.height)
            
            for (index, viewController) in enumerate(self.viewControllers) {
            
                let yOrigin = size.height * CGFloat(index)
                let newFrame =  CGRect(origin: CGPoint(x: 0, y: yOrigin), size: size)
                viewController.view.frame = newFrame
                
            }
            
            
        }, completion: { (context) -> Void in
            
        })
        
    }

    
    func populateScrollViewWithViewControllers() {
        
        for (index, viewController) in enumerate(viewControllers) {
            viewController.willMoveToParentViewController(self)
            addChildViewController(viewController)
            viewController.view.frame = frameForViewControllerAtIndex(index)
            scrollView.addSubview(viewController.view)
            viewController.didMoveToParentViewController(self)
        }
        
    }
    
    func frameForViewControllerAtIndex(index: Int) -> CGRect{
        let size = scrollView.frame.size
        let yOrigin = size.height * CGFloat(index)
        
        return CGRect(origin: CGPoint(x: 0, y: yOrigin), size: size)
    }
    
    
    
    func setContentSize() {
        var size = scrollView.frame.size
        size.height = CGFloat(size.height) * CGFloat(viewControllers.count)
        
        scrollView.contentSize = size
    }
    
    
    
    func instantiateViewControllers() -> [UIViewController] {
        
        let identifiers = ["section1", "section2"]
        let storyboard = UIStoryboard(name: "Sections", bundle: NSBundle.mainBundle())
        
        var controllers: [UIViewController] = []
        
        for identifier in identifiers {
            if let controller = storyboard.instantiateViewControllerWithIdentifier(identifier) as? UIViewController {
                controllers.append(controller)
            }
        }
        
        return controllers
    }

    
    
    //MARK: UIScrollView Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollamount = scrollView.contentOffset.y % self.view.frame.height
        let percentage = scrollamount / self.view.frame.height
        
        
        for aVC in viewControllers {
            if let section = aVC as? SectionViewController {
                section.didScroll!(toPercentage: Float(percentage))
            }
        }
        
        
        
    }
    
    

}























