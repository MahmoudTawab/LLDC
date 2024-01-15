//
//  Checkbox.swift
//  Bnkit
//
//  Created by Mahmoud Tawab on 9/10/20.
//  Copyright © 2020 Mahmoud Tawab. All rights reserved.
//

import UIKit


class Checkbox: UIButton {

    @IBInspectable var Color:UIColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1) {
        didSet {
        self.setNeedsLayout()
        }
    }
    
     lazy var Button : ButtonNotEnabled = {
     let Button = ButtonNotEnabled(type: .system)
     Button.Radius = false
     Button.backgroundColor = .clear
     Button.layer.borderWidth = ControlWidth(1.5)
     Button.layer.borderColor = Color.cgColor
     Button.contentEdgeInsets.bottom = 1
     Button.contentEdgeInsets.right = 1
     Button.translatesAutoresizingMaskIntoConstraints = false
     Button.addTarget(self, action: #selector(Targe), for: .touchUpInside)
     Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: ControlWidth(15.5))
     return Button
     }()
    
    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.textAlignment = .left
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    override func draw(_ rect: CGRect) {
    addSubview(Button)
    Button.heightAnchor.constraint(equalTo: Button.widthAnchor).isActive = true
    Button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    Button.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    Button.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(8.5)).isActive = true

         
    addSubview(Label)
    Label.centerYAnchor.constraint(equalTo: Button.centerYAnchor).isActive = true
    Label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    Label.leadingAnchor.constraint(equalTo: Button.trailingAnchor,constant: ControlX(10)).isActive = true
    }
    
  @objc func Targe() {
    Button.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
    self.Button.transform = .identity
    })
    
    UIView.animate(withDuration: 0.2) {
    if self.Button.tag == 0 {
    self.Button.setTitle("✓", for: .normal)
    self.Button.setTitleColor(self.Color, for: .normal)
    self.Button.layer.borderColor = self.Color.cgColor
    self.Button.tag = 1
    }else{
    self.Button.setTitle("", for: .normal)
    self.Button.layer.borderColor = self.Color.cgColor
    self.Button.tag = 0
    }
    }
}
    var Select = Bool()
    func Select(IsSelect:Bool , text:String) {
    Label.text = text 
    if IsSelect {
    Select = true
    self.Button.setTitle("✓", for: .normal)
    self.Button.setTitleColor(Color, for: .normal)
    self.Button.layer.borderColor = Color.cgColor
    self.Button.tag = 1
    }else{
    Select = false
    self.Button.setTitle("", for: .normal)
    self.Button.layer.borderColor = Color.cgColor
    self.Button.tag = 0
    }
    }

}
