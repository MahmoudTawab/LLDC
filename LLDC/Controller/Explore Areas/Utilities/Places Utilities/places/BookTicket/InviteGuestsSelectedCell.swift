//
//  InviteGuestsSelectedCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/08/2021.
//

import UIKit

class InviteGuestsSelectedCell: UITableViewCell {
        
    lazy var NameLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(16))
        return Label
    }()
    
    lazy var PhoneLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1087588281, green: 0.1087588281, blue: 0.1087588281, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(16))
        return Label
    }()
    
    let ProfileImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.backgroundColor = .clear
        ImageView.layer.borderWidth = 0.5
        ImageView.layer.masksToBounds = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1).cgColor
        return ImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        
        contentView.addSubview(ProfileImage)
        contentView.addSubview(NameLabel)
        contentView.addSubview(PhoneLabel)
        
        ProfileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant:ControlX(15)).isActive = true
        ProfileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ProfileImage.widthAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        ProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        ProfileImage.layer.cornerRadius = ControlX(30)
        
        NameLabel.leadingAnchor.constraint(equalTo: ProfileImage.trailingAnchor , constant: ControlX(15)).isActive = true
        NameLabel.topAnchor.constraint(equalTo: ProfileImage.topAnchor,constant: ControlX(2)).isActive = true
        NameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: ControlX(-80)).isActive = true
        NameLabel.heightAnchor.constraint(equalToConstant: ControlHeight(25)).isActive = true
        
        PhoneLabel.leadingAnchor.constraint(equalTo: NameLabel.leadingAnchor).isActive = true
        PhoneLabel.bottomAnchor.constraint(equalTo: ProfileImage.bottomAnchor,constant: ControlX(-2)).isActive = true
        PhoneLabel.trailingAnchor.constraint(equalTo: NameLabel.trailingAnchor).isActive = true
        PhoneLabel.heightAnchor.constraint(equalTo: NameLabel.heightAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
