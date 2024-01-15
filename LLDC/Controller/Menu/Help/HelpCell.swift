//
//  HelpCell.swift
//  Bnkit
//
//  Created by Mohamed Tawab on 05/02/2021.
//  Copyright © 2021 Mahmoud Tawab. All rights reserved.
//

import UIKit

class HelpCell: UICollectionViewCell {
    
     lazy var HelpTitel : UILabel = {
       let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(17))
    return Label
    }()
    
    
    lazy var HelpDetails : UILabel = {
        let Label = UILabel()
         Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
         Label.backgroundColor = .clear
         Label.translatesAutoresizingMaskIntoConstraints = false
         Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(14))
     return Label
     }()

    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.translatesAutoresizingMaskIntoConstraints = false
    return ImageView
    }()
    
    lazy var ImageIcon : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.image = UIImage(named: "Path")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.transform = CGAffineTransform(rotationAngle: "lang".localizable == "ar" ? (.pi / 2):(-.pi / 2))
        return ImageView
    }()
    
    override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = #colorLiteral(red: 0.865517304, green: 0.8752040156, blue: 0.7897507438, alpha: 1)
        
    addSubview(HelpTitel)
    addSubview(HelpDetails)
    addSubview(ImageView)
    addSubview(ImageIcon)
    
    ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(15)).isActive = true
    ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor ,constant: ControlX(-20)).isActive = true
    ImageView.topAnchor.constraint(equalTo: self.topAnchor ,constant: ControlX(20)).isActive = true
    ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
            
    HelpTitel.heightAnchor.constraint(equalToConstant: ControlX(25)).isActive = true
    HelpTitel.topAnchor.constraint(equalTo: self.topAnchor ,constant: ControlX(15)).isActive = true
    HelpTitel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor, constant: ControlX(10)).isActive = true
    HelpTitel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-35)).isActive = true
    
    HelpDetails.heightAnchor.constraint(equalTo: HelpTitel.heightAnchor).isActive = true
    HelpDetails.leadingAnchor.constraint(equalTo: HelpTitel.leadingAnchor).isActive = true
    HelpDetails.trailingAnchor.constraint(equalTo: HelpTitel.trailingAnchor).isActive = true
    HelpDetails.bottomAnchor.constraint(equalTo: self.bottomAnchor ,constant: ControlX(-15)).isActive = true
        
    ImageIcon.heightAnchor.constraint(equalToConstant: ControlWidth(19)).isActive = true
    ImageIcon.widthAnchor.constraint(equalToConstant: ControlWidth(19)).isActive = true
    ImageIcon.topAnchor.constraint(equalTo: self.topAnchor ,constant: ControlX(20)).isActive = true
    ImageIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
