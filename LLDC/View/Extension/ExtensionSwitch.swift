//
//  ExtensionSwitch.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit

extension UISwitch {
    func set(offTint color: UIColor ) {
        let minSide = min(bounds.size.height, bounds.size.width)
        layer.cornerRadius = minSide / 2
        backgroundColor = color
        tintColor = color
    }
}
