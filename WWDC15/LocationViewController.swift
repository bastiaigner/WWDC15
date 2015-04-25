//
//  LocationViewController.swift
//  WWDC15
//
//  Created by Bastian Aigner on 4/21/15.
//  Copyright (c) 2015 Bastian Aigner. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, SectionViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // set map location to US
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.3130432088809, longitude: -100.634765625), span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)), animated: false)
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    var didShowMapAnimation = false // set to true once the map animation has been played

    
    
    func didScroll(toPercentage percentage: Float) {
        
    }
    
    func didFinishScrollingToSlide(#fromBottom: Bool) {
        if !didShowMapAnimation {
            didShowMapAnimation = true
            
            
            // keyframe animations didn't work properly
            
            
            UIView.animateWithDuration(3, animations: { () -> Void in
                // pan to europe
                self.mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 48.039833, longitude: 10.679078)
            }, completion: { (completed) -> Void in

                UIView.animateWithDuration(3, animations: { () -> Void in
                    // zoom
                    self.mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.039833, longitude: 10.679078), span: MKCoordinateSpan(latitudeDelta: 3.3, longitudeDelta: 3.3))
                }, completion: { (completed) -> Void in
                    // add home pin
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.4 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                        let pin = MapPin(coordinate: CLLocationCoordinate2D(latitude: 48.039833, longitude: 10.679078), title: "My home", subtitle: nil)
                        self.mapView.addAnnotation(pin)
                        self.mapView.selectAnnotation(pin, animated: true)
                    })
                    
                    
                })
               
            })
            

        
            
            
            
        }
        
        
        
    }

}


// pin helper class

class MapPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        if let the_subtitle = subtitle{
            self.subtitle = the_subtitle
        }
        
    }
}

