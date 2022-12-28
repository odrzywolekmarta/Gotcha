//
//  File.swift
//  Pokedex
//
//  Created by Majka on 08/11/2022.
//

import Foundation
import UIKit

extension UIView {
    func applyShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    func makeRound() {
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    func makeRound(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        clipsToBounds = true
    }
}

extension UIImage {
    func addShadow(blurSize: CGFloat = 6.0) -> UIImage {
                        
            let shadowColor = UIColor(white:0.0, alpha:0.8).cgColor
            
            let context = CGContext(data: nil,
                                    width: Int(self.size.width + blurSize),
                                    height: Int(self.size.height + blurSize),
                                    bitsPerComponent: self.cgImage!.bitsPerComponent,
                                    bytesPerRow: 0,
                                    space: CGColorSpaceCreateDeviceRGB(),
                                    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
            
            context.setShadow(offset: CGSize(width: blurSize/2,height: -blurSize/2),
                              blur: blurSize,
                              color: shadowColor)
            context.draw(self.cgImage!,
                         in: CGRect(x: 0, y: blurSize, width: self.size.width, height: self.size.height),
                         byTiling:false)
            
            return UIImage(cgImage: context.makeImage()!)
        }
}

extension UIColor {
  func lighter(by percentage: CGFloat = 30.0) -> UIColor {
    return self.adjustBrightness(by: abs(percentage))
  }
  
  func darker(by percentage: CGFloat = 30.0) -> UIColor {
    return self.adjustBrightness(by: -abs(percentage))
  }
  
  func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
    var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
      if b < 1.0 {
        let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0.0)
        return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
      } else {
        let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
        return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
      }
    }
    return self
  }
    
}

extension UINavigationBar {
    func update(backroundColor: UIColor? = nil, titleColor: UIColor? = nil) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            if let backroundColor = backroundColor {
                appearance.backgroundColor = backroundColor
            }
            
            if let titleColor = titleColor {
                appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            }
            
            if let backButtonFont = UIFont(name: Constants.customFontBold, size: 17) {
                appearance.backButtonAppearance.normal.titleTextAttributes =
                [NSAttributedString.Key.font: backButtonFont,
                 NSAttributedString.Key.foregroundColor: UIColor.white]
            }
            
            if let clearButtonFont = UIFont(name: Constants.customFontBold, size: 17) {
                appearance.buttonAppearance.normal.titleTextAttributes =
                [NSAttributedString.Key.font: clearButtonFont,
                 NSAttributedString.Key.foregroundColor: UIColor.white]
            }
            
            if let titleFont = UIFont(name: Constants.customFontBold, size: 20) {
                appearance.titleTextAttributes = [NSAttributedString.Key.font: titleFont,
                                                  NSAttributedString.Key.foregroundColor: UIColor.white]
            }
            
            appearance.shadowColor = .clear
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
            
        } else {
            barStyle = .blackTranslucent
            if let backroundColor = backroundColor {
                barTintColor = backroundColor
            }
            if let titleColor = titleColor {
                titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            }
        }
        
    }
}

extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
}
