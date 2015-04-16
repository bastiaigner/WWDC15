//
//  ParallaxImageSource.swift
//  WWDC15
//
//  Created by Bastian Aigner on 4/15/15.
//  Copyright (c) 2015 Bastian Aigner. All rights reserved.
//

import Foundation
import UIKit


class ParallaxImageSource {
    init() {
        
    }
    
    
    
    
    
    
    class func generateTextViews(layerOffsets: [Float], mainWidth: CGFloat, height: CGFloat, texts: [CGFloat: String], leftReadabilityOffset: CGFloat) -> [Float : UIView]{
        
        
        
        let layerCount = layerOffsets.count
        
        var finishedLayers: [Float : UIView] = [Float : UIView]()
        
        var layerChars: [Int : [CGFloat : Character]] = [Int : [CGFloat : Character]]() // [LayerIndex : [Char Offset from left : Character]]
        
        
        
        
        for (xPosition, string) in texts {
            
            
            var cursorOffset: CGFloat = 0
            
            
            for (charIndex, char) in enumerate(string) {
                
                
                //let targetLayer = Int(arc4random_uniform(UInt32(layerCount)))
                
                
                
                let targetLayer = charIndex % layerCount
                
                
                
                
                
                
                
                
                let calculatedLeftOffset: CGFloat = CGFloat(xPosition) * CGFloat(layerOffsets[targetLayer]) + cursorOffset
                
                if layerChars[targetLayer] == nil {
                    layerChars[targetLayer] = [CGFloat : Character]()
                }
                
                
                
                cursorOffset += (String(char) as NSString).sizeWithAttributes([NSFontAttributeName : UIFont(name: "HelveticaNeue-UltraLight", size: 130)!]).width
                
                
                layerChars[targetLayer]?[calculatedLeftOffset] = char
            }
            
        }
        
        
        println(layerChars)
        
        
        for (index, offset) in enumerate(layerOffsets) {
            
            
            var currentLayerChars = [CGFloat : Character]()
            
            if layerChars[index] != nil {
                currentLayerChars = layerChars[index]!
            }
            
            
            
            finishedLayers[offset] = ParallaxImageSource.generateLayer(offset, width: CGFloat(offset) * mainWidth, height: height, text: currentLayerChars, leftReadabilityOffset: leftReadabilityOffset)
            
            
            
            
            
        }
        
        
        
        return finishedLayers
        
    }
    
    
    private class func generateLayer(offset: Float, width: CGFloat, height: CGFloat, text: [CGFloat: Character], leftReadabilityOffset: CGFloat) -> UIView {
        
        
        
            var drawingView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width + (leftReadabilityOffset * CGFloat(offset)), height: height)))
        
            
            
            for (xPosition, char) in text {
                
                //(string as NSString).drawAtPoint(, withAttributes: [NSFontAttributeName : UIFont.systemFontOfSize(50), NSForegroundColorAttributeName : UIColor.whiteColor()])
                let textLayer = CATextLayer()
                textLayer.string = String(char)
                textLayer.frame = CGRect(origin: CGPoint(x: xPosition + leftReadabilityOffset, y: 50), size: textLayer.string.sizeWithAttributes([NSFontAttributeName : UIFont(name: "HelveticaNeue-UltraLight", size: 130)!]))
                textLayer.font = UIFont(name: "HelveticaNeue-UltraLight", size: 130)
                textLayer.fontSize = 130
                textLayer.contentsScale = UIScreen.mainScreen().scale
                textLayer.foregroundColor = UIColor.whiteColor().CGColor
                drawingView.layer.addSublayer(textLayer)
                
            }
            
            return drawingView
        
        
    }
    
    
    
}





















