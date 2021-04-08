//
//  UIImageExtension.swift
//  CoreDataCombineSwiftUISample
//
//  Created by Ankit Thakur on 06/04/21.
//

import Foundation
import UIKit

extension UIImage {
    // referred from https://nshipster.com/image-resizing/#technique-1-drawing-to-a-uigraphicsimagerenderer
    // Thanks to Matts from NSHipster
    /**
     UIGraphicsImageRenderer is a relatively new API, introduced in iOS 10 to replace the older, UIGraphicsBeginImageContextWithOptions / UIGraphicsEndImageContext APIs. You construct a UIGraphicsImageRenderer by specifying a point size. The image method takes a closure argument and returns a bitmap that results from executing the passed closure. In this case, the result is the original image scaled down to draw within the specified bounds.
     */
    func resizedImage(withImageFilePath filePath: String, for size: CGSize) -> UIImage? {
        guard let image = UIImage(contentsOfFile: filePath) else {return nil}
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func resizedImage( for size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }

}
