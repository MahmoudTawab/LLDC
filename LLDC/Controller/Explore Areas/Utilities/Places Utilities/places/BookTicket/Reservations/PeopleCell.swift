//
//  PeopleCell.swift
//  LLDC
//
//  Created by Emojiios on 04/04/2022.
//

import UIKit

class PeopleCell: UICollectionViewCell {
    
    lazy var ProfileImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ImageView.backgroundColor = .clear
        ImageView.layer.masksToBounds = true
        ImageView.contentMode = .scaleAspectFill
        ImageView.image = UIImage(named: "Profile")
        ImageView.layer.borderWidth = ControlWidth(1)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var LabelName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(15))
        return Label
    }()
    
    lazy var QrImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = .black
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.image = UIImage(named: "IconQR")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(ProfileImage)
        ProfileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ProfileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        ProfileImage.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        ProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        ProfileImage.layer.cornerRadius = ControlX(20)
        
        addSubview(LabelName)
        LabelName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        LabelName.leadingAnchor.constraint(equalTo: ProfileImage.trailingAnchor,constant: ControlX(10)).isActive = true
        LabelName.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-70)).isActive = true
        LabelName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(QrImage)
        QrImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        QrImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
        QrImage.widthAnchor.constraint(equalToConstant: ControlWidth(36)).isActive = true
        QrImage.heightAnchor.constraint(equalToConstant: ControlWidth(36)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
