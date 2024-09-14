//
//  UIImage.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import UIKit
import SwiftPlus

// MARK: Need documentation and UTs
extension UIImage {
    public var base64DataString: String? {
        self.pngData()?.base64EncodedString()
    }
    
    public var base64DataStringFromJPEG: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
    
    public func getFileSize() -> Double {
        return self.jpegData(compressionQuality: 1)?.mBSize.toDouble ?? 0
    }
        
    public func scaledImage(scaledToSize newSize: CGSize) -> UIImage {
        let image = self
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public func toData(_ quality: CGFloat) -> Data? {
        self.jpegData(compressionQuality: quality)
    }
    
    public func overlay(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    public func makeBlackAndWhite(_ handler: @Sendable @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            guard let currentCGImage = self.cgImage else {
                onMainThread {
                    handler(nil)
                }
                return
            }
            let currentCIImage = CIImage(cgImage: currentCGImage)
            
            let filter = CIFilter(name: "CIColorMonochrome")
            filter?.setValue(currentCIImage, forKey: "inputImage")
            
            // set a gray value for the tint color
            filter?.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: "inputColor")
            
            filter?.setValue(1.0, forKey: "inputIntensity")
            guard let outputImage = filter?.outputImage else {
                onMainThread {
                    handler(nil)
                }
                return
            }
            
            let context = CIContext()
            
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                onMainThread {
                    handler(UIImage(cgImage: cgimg))
                }
            } else {
                onMainThread {
                    handler(nil)
                }
            }
        }
    }
}
