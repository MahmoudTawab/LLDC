//
//  ExtensionTextField.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit

extension UITextField {
    @objc func NoErrorEmail() -> Bool {
    if isValidEmail(emailID: self.text ?? "") != false {
    return true
    }else{
    return false
    }
    }

    @objc func NoErrorPassword() -> Bool {
    if (self.text?.count) ?? 0 > 5 {
    return true
    }else{
    return false
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

    func isValidEmail(emailID:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with:emailID)
    }
    
}

