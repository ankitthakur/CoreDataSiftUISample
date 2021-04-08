//
//  UIViewExtension.swift
//  CoreDataCombineSwiftUISample
//
//  Created by Ankit Thakur on 06/04/21.
//

import Foundation
import UIKit

extension UIView {
    func profileGradientLayer(withWidth width:CGFloat, withBorderWidth borderWidth:CGFloat) -> CAGradientLayer {
        let gradientLayerName = "gradientLayer"
        if let subLayers = self.layer.sublayers {
            let gradientLayers = subLayers.filter{$0.name == gradientLayerName}
            if gradientLayers.count == 1 {
                return gradientLayers.first! as! CAGradientLayer
            }
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = gradientLayerName
        gradientLayer.colors = [
            
            UIColor(red: 0.546, green: 0.546, blue: 0.546, alpha: 1).cgColor,
            
            UIColor(red: 0.796, green: 0.796, blue: 0.796, alpha: 1).cgColor
            
        ]
        
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        gradientLayer.bounds = self.bounds.insetBy(dx: -0.5*width, dy: -0.5*width)
        gradientLayer.position = self.center
        self.layer.cornerRadius = width/2
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
        self.backgroundColor = .white
        return gradientLayer
    }
}
