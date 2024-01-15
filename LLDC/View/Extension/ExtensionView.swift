//
//  ExtensionView.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat ,fillColor:CGColor ,_ shadowOpacity:Float = 0.4) {
    self.backgroundColor = UIColor.clear
    let path1 = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

    let maskLayer1 = CAShapeLayer()
    maskLayer1.path = path1.cgPath
    maskLayer1.fillColor = fillColor
    maskLayer1.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
    maskLayer1.shadowPath = maskLayer1.path
    maskLayer1.shadowOffset = CGSize(width: 2, height: 1)
    maskLayer1.shadowOpacity = shadowOpacity
    maskLayer1.shadowRadius = 4
    self.layer.insertSublayer(maskLayer1, at: 0)
    }
    
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    
    func Shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true
                    
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)

        shake.fromValue = fromValue
        shake.toValue = toValue
                
        layer.add(shake, forKey: "position")
    }
    
    func startShimmeringEffect(animationSpeed: Float = 1.4,repeatCount: Float = 1000) {
      
      let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
      let blackColor = UIColor.black.cgColor
      
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [blackColor, lightColor, blackColor]
      gradientLayer.frame = CGRect(x: -self.bounds.size.width, y: -self.bounds.size.height, width: 3 * self.bounds.size.width, height: 3 * self.bounds.size.height)
      
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
      gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
      gradientLayer.locations =  [0.35, 0.50, 0.65] //[0.4, 0.6]
      self.layer.mask = gradientLayer
      
      // Add animation over gradient Layer  ->4
      CATransaction.begin()
      let animation = CABasicAnimation(keyPath: "locations")
      animation.fromValue = [0.0, 0.1, 0.2]
      animation.toValue = [0.8, 0.9, 1.0]
      animation.duration = CFTimeInterval(animationSpeed)
      animation.repeatCount = repeatCount
      CATransaction.setCompletionBlock { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.layer.mask = nil
      }
      gradientLayer.add(animation, forKey: "shimmerAnimation")
      CATransaction.commit()
    }
    
    func stopShimmeringEffect() {
      self.layer.mask = nil
    }
    
    func addBottomLine(color: UIColor, height: CGFloat , space: CGFloat) {
    let bottomView = UIView()
    bottomView.translatesAutoresizingMaskIntoConstraints = false
    bottomView.backgroundColor = color
    self.addSubview(bottomView)
    bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: space).isActive = true
    bottomView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    bottomView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    bottomView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
}


extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){

        self.init()

        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
             path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }

        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }

        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }

        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        path.closeSubpath()
        cgPath = path
    }
}

