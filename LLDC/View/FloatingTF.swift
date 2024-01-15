//
//  FloatingTF.swift
//  FloatingTF
//
//  Created by Abhilash  on 11/02/17.
//  Copyright © 2017 Abhilash . All rights reserved.
//

import UIKit

public enum FloatingEnum {
    case IsEmail,ReadOnly,IsPassword,none
}

class FloatingTF: UITextField, UITextFieldDelegate {
    
  let floatingTitleLabelHeight = ControlWidth(30)
  var isFloatingTitleHidden = true
  let TitleError = UIButton()
  let IconError = UILabel()
  let title = UILabel()
  let bottomLineLayer = UIView()
  var Enum:FloatingEnum = .none
  
  required init?(coder aDecoder:NSCoder) {
    super.init(coder:aDecoder)
    setup()
  }
    
  override init(frame:CGRect) {
    super.init(frame:frame)
    setup()
  }
    
  fileprivate func setup() {
    self.delegate = self
    self.clipsToBounds = false
    self.backgroundColor = .clear
    self.autocorrectionType = .no
    self.keyboardAppearance = .light
    self.tintColor = titleActiveTextColor
    self.textColor = titleActiveTextColor
    self.translatesAutoresizingMaskIntoConstraints = false
    
    if #available(iOS 12.0, *) {
    self.textContentType = .oneTimeCode
    }
      
    self.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(16))
      
    TitleError.alpha = 0.0
    TitleError.contentVerticalAlignment = .top
    TitleError.backgroundColor = .clear
    TitleError.titleLabel?.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(12))
    TitleError.translatesAutoresizingMaskIntoConstraints = false
    TitleError.contentHorizontalAlignment = "lang".localizable == "ar" ? .right : .left
      
    IconError.alpha = 0.0
    IconError.text = "!"
    IconError.textColor = .white
    IconError.textAlignment = .center
    IconError.layer.masksToBounds = true
    IconError.font = UIFont.systemFont(ofSize: ControlWidth(14))
    IconError.translatesAutoresizingMaskIntoConstraints = false
          
    // Set up title label
    title.alpha = 0.0
    title.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
    title.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(13))
    if let str = placeholder , !str.isEmpty {
    title.text = str.capitalized
    title.sizeToFit()
    }
      
    self.title.frame = CGRect(x: ControlWidth(20), y: ControlY(20), width: self.frame.size.width, height: self.floatingTitleLabelHeight)
    self.addSubview(title)
      
    setBottomLineLayerFrame()
      
    self.addTarget(self, action: #selector(DidBegin), for: .editingDidBegin)
    self.addTarget(self, action: #selector(DidBegin), for: .editingChanged)
    self.addTarget(self, action: #selector(DidEnd), for: .editingDidEnd)
  }
    
    
    @objc func DidEnd() {
    Icon.alpha = 1
    TitleError.alpha = 0
    IconError.alpha = 0
    self.layer.borderColor = #colorLiteral(red: 0.8661956191, green: 0.8661957383, blue: 0.8661957383, alpha: 1).cgColor
    }
    
    
    @objc func DidBegin() {

    if ShowError {
    if Enum == .IsEmail {
    self.addTarget(self, action: #selector(NoErrorEmail), for: .editingChanged)
    SetUpError(IsError: NoErrorEmail(), Error: "Enter the email correctly".localizable)
    }
        
    if Enum == .IsPassword {
    self.addTarget(self, action: #selector(NoErrorPassword), for: .editingChanged)
    SetUpError(IsError: NoErrorPassword(), Error: "Password must be more than 6 elements".localizable)
    }
        
    if Enum == .none {
    self.addTarget(self, action: #selector(NoError), for: .editingDidBegin)
    SetUpError(IsError: NoError(), Error: "It can't be empty".localizable)
    }
        
    }
    }
    
    
    func SetUpError(IsError:Bool,Error:String) {
    self.layer.borderColor = !IsError ? #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor : #colorLiteral(red: 0.8661956191, green: 0.8661957383, blue: 0.8661957383, alpha: 1).cgColor
            
    TitleError.setTitle(!IsError ? Error : "", for: .normal)
    TitleError.alpha = !IsError ? 1 : 0
            
    if IconImage == nil {
    IconError.alpha = !IsError ? 1 : 0
    IconError.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            
    self.rightViewMode = .always
    self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(30) , height: self.frame.height))
    }
    
    TitleError.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
    }
    
    let Icon = UIButton()
    @IBInspectable var IconImage : UIImage? {
        didSet {
            let Image = IconImage?.withInset(UIEdgeInsets(top: ControlY(1.5), left: ControlX(1.5), bottom: ControlY(1.5), right: 0))
            Icon.setBackgroundImage(Image, for: .normal)
        }
    }

    func SetUpIcon(LeftOrRight:Bool , Width:CGFloat = 23 ,Height :CGFloat = 22) {
    Icon.backgroundColor = .clear
    Icon.translatesAutoresizingMaskIntoConstraints = false
    addSubview(Icon)
        
    if LeftOrRight {
    Icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(2)).isActive = true
    self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(Width) + ControlX(15), height: self.frame.height))
    self.leftViewMode = .always
    }else{
    Icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-2)).isActive = true
    self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(Width) + ControlX(15), height: self.frame.height))
    self.rightViewMode = .always
    }
        
    Icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    Icon.widthAnchor.constraint(equalToConstant: ControlWidth(Width)).isActive = true
    Icon.heightAnchor.constraint(equalToConstant: ControlWidth(Height)).isActive = true
    }
  
    @IBInspectable var TitleHidden : Bool = true
    @IBInspectable var ShowError : Bool = true
    @IBInspectable var enableFloatingTitle : Bool = true
    @IBInspectable var titleActiveTextColor:UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
    didSet {
    self.textColor = titleActiveTextColor
    }
  }

   override func layoutSubviews() {
    super.layoutSubviews()       
       
       if !TitleHidden {
       if let txt = text , txt.isEmpty {
         // Hide
       if !isFloatingTitleHidden {
       hideTitle()
       }
       } else if enableFloatingTitle{
       showTitle()
       }
       }
  }

    func showTitle() {
    UIView.animate(withDuration: 0.3) {
    // Animation
    self.title.text = self.placeholder
    self.title.alpha = 1.0
    self.title.frame = CGRect(x: 0, y: -self.floatingTitleLabelHeight , width: self.frame.size.width, height: self.floatingTitleLabelHeight)
    } completion: { _ in
    self.isFloatingTitleHidden = false
    }
    }
    
    fileprivate func hideTitle() {
    UIView.animate(withDuration: 0.3) {
    // Animation
    self.title.alpha = 0.0
    self.title.frame = CGRect(x: ControlWidth(20), y: ControlY(10), width: self.frame.size.width, height: self.floatingTitleLabelHeight)
    } completion: { _ in
    self.isFloatingTitleHidden = true
    }
    }

	/// setBottomLineLayerFrame( - Description:
	private func setBottomLineLayerFrame() {
        
    self.addSubview(TitleError)
    self.addSubview(IconError)
        
    bottomLineLayer.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    bottomLineLayer.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(bottomLineLayer)
    bottomLineLayer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    bottomLineLayer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    bottomLineLayer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    bottomLineLayer.heightAnchor.constraint(equalToConstant: ControlX(1)).isActive = true
        
    IconError.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    IconError.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-6)).isActive = true
    IconError.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    IconError.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    IconError.layer.cornerRadius = ControlX(10)
                
    TitleError.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    TitleError.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    TitleError.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    TitleError.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    }
      
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Enum == .ReadOnly {
        return false
        }
        
        if textField.keyboardType == .numberPad {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
        }
        
        return true
    }
    
    
}
