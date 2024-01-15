//
//  ViewProfile.swift
//  LLDC
//
//  Created by Emojiios on 29/03/2022.
//

import UIKit
import SDWebImage

class ViewProfile: UIView {
    
    @IBInspectable var TextName:String = "" {
      didSet {
          LabelName.text = TextName
      }
    }
    
    lazy var ProfileImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ImageView.backgroundColor = .clear
        ImageView.layer.masksToBounds = true
        ImageView.contentMode = .scaleAspectFill
        ImageView.image = UIImage(named: "Profile")
        ImageView.layer.borderWidth = ControlWidth(2)
        ImageView.layer.cornerRadius = ControlX(25)
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var LabelName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(20))
        return Label
    }()
    
    lazy var ProfileView : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(16))
        return Label
    }()
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelName,ProfileView])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()

    lazy var ViewQR : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        View.isUserInteractionEnabled = true
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var IconQR : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = .white
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.image = UIImage(named: "IconQR")
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var SearchButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.setImage(UIImage(named: "search"), for: .normal)
        Button.backgroundColor = .clear
        Button.isHidden = true
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        addSubview(ProfileImage)
        ProfileImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ProfileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        ProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        ProfileImage.widthAnchor.constraint(equalTo: ProfileImage.heightAnchor).isActive = true
        
        addSubview(Stack)
        Stack.leadingAnchor.constraint(equalTo: ProfileImage.trailingAnchor,constant: ControlX(10)).isActive = true
        Stack.widthAnchor.constraint(equalTo: self.widthAnchor ,constant: ControlWidth(-190)).isActive = true
        Stack.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlWidth(5)).isActive = true
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        
        addSubview(ViewQR)
        ViewQR.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlWidth(8)).isActive = true
        ViewQR.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ViewQR.heightAnchor.constraint(equalToConstant: ControlWidth(34)).isActive = true
        ViewQR.widthAnchor.constraint(equalToConstant: ControlWidth(54)).isActive = true
        
        ViewQR.addSubview(IconQR)
        IconQR.topAnchor.constraint(equalTo: ViewQR.topAnchor,constant: ControlWidth(7)).isActive = true
        IconQR.leadingAnchor.constraint(equalTo: ViewQR.leadingAnchor,constant: ControlX(14)).isActive = true
        IconQR.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        IconQR.widthAnchor.constraint(equalTo: IconQR.heightAnchor).isActive = true
        
        addSubview(SearchButton)
        SearchButton.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlWidth(5)).isActive = true
        SearchButton.leadingAnchor.constraint(equalTo: Stack.trailingAnchor,constant: ControlX(10)).isActive = true
        SearchButton.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        SearchButton.widthAnchor.constraint(equalTo: SearchButton.heightAnchor).isActive = true
        
        SetDataUser()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SetDataUser), name: ProfileVC.ProfileNotification , object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let Color = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1).cgColor
        ViewQR.roundCorners(corners: "lang".localizable == "ar" ? [.topRight,.bottomRight] : [.topLeft,.bottomLeft], radius: ControlWidth(15), fillColor: Color)
    }

    @objc func SetDataUser() {
    TextName = getProfileObject().fullName ?? "User Name"
    ProfileImage.sd_setImage(with: URL(string: getProfileObject().profileImg ?? ""), placeholderImage: UIImage(named: "Profile"))
    }
    
}
