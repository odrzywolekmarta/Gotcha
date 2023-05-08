//
//  File.swift
//  Pokedex
//
//  Created by Majka on 08/11/2022.
//

import Foundation
import UIKit

//MARK: - UIView

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
    
    func addBluredBackground() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurView)
        self.sendSubviewToBack(blurView)
    }
}

//MARK: - UIImage

extension UIImage {
    static func withColor(_ color: UIColor) -> UIImage {
        let onePx = pixelsToPoints(1)
        let rect = CGRect(x: 0, y: 0, width: onePx, height: onePx)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setShouldAntialias(false)
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return image
        }
        return UIImage()
    }
    
    static func pixelsToPoints(_ pixels: CGFloat) -> CGFloat {
        return pixels / UIScreen.main.scale
    }
    
    func addShadow(blurSize: CGFloat = 6.0) -> UIImage {
        
        let shadowColor = UIColor(white:0.0, alpha:0.8).cgColor
        
        guard let image = self.cgImage else {
            return UIImage()
        }
        
        guard let context = CGContext(data: nil,
                                      width: Int(self.size.width + blurSize),
                                      height: Int(self.size.height + blurSize),
                                      bitsPerComponent: image.bitsPerComponent,
                                      bytesPerRow: 0,
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return UIImage()
        }
        
        context.setShadow(offset: CGSize(width: blurSize/2,height: -blurSize/2),
                          blur: blurSize,
                          color: shadowColor)
        context.draw(image,
                     in: CGRect(x: 0, y: blurSize, width: self.size.width, height: self.size.height),
                     byTiling:false)
        
        guard let finalImage = context.makeImage() else {
            return UIImage()
        }
        
        return UIImage(cgImage: finalImage)
    }
}

//MARK: - UIColor

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

//MARK: - UINavigationBar

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
            
            let blankImage = UIImage.withColor(UIColor.white.withAlphaComponent(0))
            appearance.setBackIndicatorImage(blankImage, transitionMaskImage: blankImage)
            
            
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
    
    func addTitleLabel(_ navBar: UINavigationBar) {
        
        let titleFrame = CGRect(x: 0, y: 0, width: navBar.frame.width, height: navBar.frame.height)
        let titleLabel = UILabel(frame: titleFrame)
        
        titleLabel.text = Constants.gotcha.uppercased()
        titleLabel.applyShadow()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: Constants.customFontBold, size: Constants.barTitleFontSize)
        
        navBar.addSubview(titleLabel)
    }
}

//MARK: - UILabel

extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
}

//MARK: - UIButton

extension UIButton {
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
            button.transform = transform
        }, completion: nil)
    }
    
}

