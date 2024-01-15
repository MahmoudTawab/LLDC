//
//  ButtonNotEnabled.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 02/12/2021.
//

import UIKit

class ButtonNotEnabled: UIButton {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addTarget(self, action: #selector(NotEnabled), for: .touchUpInside)
    }

    @objc func NotEnabled() {
    self.isEnabled = false
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    self.isEnabled = true
    }
    }
    
    
    var Radius = true
    override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = Radius == true ? self.frame.height / 2 : self.frame.height / 5.5
    }
}
