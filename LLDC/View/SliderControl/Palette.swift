//
//  Palette.swift
//  TwicketSegmentedControlDemo
//
//  Created by Pol Quintana on 17/09/16.
//  Copyright © 2016 Pol Quintana. All rights reserved.
//

import UIKit

struct Palette {
    static let defaultTextColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    static let highlightTextColor = UIColor.white
    static let segmentedControlBackgroundColor = #colorLiteral(red: 0.8901693225, green: 0.9007821679, blue: 0.8833855987, alpha: 1)
    static let sliderColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)

    static func colorFromRGB(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        func amount(_ amount: CGFloat, with alpha: CGFloat) -> CGFloat {
            return (1 - alpha) * 255 + alpha * amount
        }

        let red = amount(red, with: alpha)/255
        let green = amount(green, with: alpha)/255
        let blue = amount(blue, with: alpha)/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
