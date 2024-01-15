//
//  InviteGuestsCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/07/2021.
//

import UIKit

protocol InviteGuestsDelegate {
    func ActionSelectImage(Cell:InviteGuestsCell)
}

class InviteGuestsCell: UICollectionViewCell {

    var Delegate:InviteGuestsDelegate?
    
    var IdCell : String?
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
        ImageView.layer.borderWidth = ControlHeight(0.5)
        ImageView.layer.masksToBounds = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1).cgColor
        return ImageView
    }()
    
    lazy var SelectButton:UIButton = {
        let Button = UIButton()
        Button.backgroundColor = .clear
        Button.setBackgroundImage(UIImage(named: "AddNoSelect"), for: .normal)
        Button.addTarget(self, action: #selector(ActionSelect), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    @objc func ActionSelect() {
    Delegate?.ActionSelectImage(Cell: self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(ProfileImage)
        contentView.addSubview(SelectButton)
        
        contentView.addSubview(NameLabel)
        contentView.addSubview(PhoneLabel)
        
        ProfileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        ProfileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: ControlX(-5)).isActive = true
        ProfileImage.widthAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        ProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        ProfileImage.layer.cornerRadius = ControlX(30)
        
        NameLabel.leadingAnchor.constraint(equalTo: ProfileImage.trailingAnchor , constant:ControlX(15)).isActive = true
        NameLabel.topAnchor.constraint(equalTo: ProfileImage.topAnchor,constant: ControlX(4)).isActive = true
        NameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: ControlX(-80)).isActive = true
        NameLabel.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        
        PhoneLabel.leadingAnchor.constraint(equalTo: NameLabel.leadingAnchor).isActive = true
        PhoneLabel.bottomAnchor.constraint(equalTo: ProfileImage.bottomAnchor,constant: ControlX(-4)).isActive = true
        PhoneLabel.trailingAnchor.constraint(equalTo: NameLabel.trailingAnchor).isActive = true
        PhoneLabel.heightAnchor.constraint(equalTo: NameLabel.heightAnchor).isActive = true
        
        SelectButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-18)).isActive = true
        SelectButton.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
        SelectButton.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        SelectButton.heightAnchor.constraint(equalTo: SelectButton.widthAnchor).isActive = true
        
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionSelect)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
