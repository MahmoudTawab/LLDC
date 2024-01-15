//
//  ExtensionTextView.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit

extension UITextView {
    var spasing:CGFloat {
    get {return 0}
    set {
    let Color = self.textColor
    let textAlignment = self.textAlignment
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = newValue
    let attributedString = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, .font: self.font ?? UIFont.italicSystemFont(ofSize:ControlWidth(14))])
    self.attributedText = attributedString
    self.textAlignment = textAlignment
    self.textColor = Color
    }
    }
    
    @objc func NoError() -> Bool {
    if self.text?.TextNull() == false {
    if !self.isFirstResponder {
    self.Shake()
    self.becomeFirstResponder()
    self.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    UIView.animate(withDuration: 0.8) {
    self.layer.borderColor = #colorLiteral(red: 0.8661956191, green: 0.8661957383, blue: 0.8661957383, alpha: 1).cgColor
    }
    }
    }
    return false
    }else{
    return true
    }
    }
}

