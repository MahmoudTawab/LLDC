//
//  ProfileImageCell.swift
//  LLDC
//
//  Created by Emojiios on 30/03/2022.
//

import UIKit
import SDWebImage

protocol ProfileImageDelegate {
    func ProfileEdit()
}

class ProfileImageCell: UICollectionViewCell {
 
    var Delegate : ProfileImageDelegate?
    lazy var ProfileImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ImageView.backgroundColor = .clear
        ImageView.layer.masksToBounds = true
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.borderWidth = ControlWidth(2)
        ImageView.layer.cornerRadius = ControlX(28)
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionEdit)))
        return ImageView
    }()
    
    lazy var LabelName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(20))
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionEdit)))
        return Label
    }()
    
    lazy var ProfileEdit : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    @objc func ActionEdit() {
    Delegate?.ProfileEdit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    backgroundColor = .clear
        
    addSubview(ProfileImage)
    ProfileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    ProfileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    ProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(56)).isActive = true
    ProfileImage.widthAnchor.constraint(equalTo: ProfileImage.heightAnchor).isActive = true

    addSubview(LabelName)
    LabelName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    LabelName.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    LabelName.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-40)).isActive = true
    LabelName.leadingAnchor.constraint(equalTo: ProfileImage.trailingAnchor,constant: ControlX(10)).isActive = true
            
    addSubview(ProfileEdit)
    ProfileEdit.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    ProfileEdit.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    ProfileEdit.widthAnchor.constraint(equalTo: LabelName.heightAnchor).isActive = true
    ProfileEdit.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
