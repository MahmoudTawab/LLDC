//
//  MenuCell.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 30/12/2021.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
     lazy var MenuLabel : UILabel = {
       let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(17))
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
    layer.cornerRadius = ControlX(10)
        
    addSubview(MenuLabel)
    addSubview(ImageView)
    addSubview(ImageIcon)
    
    ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(20)).isActive = true
    ImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
    ImageView.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
            
    MenuLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    MenuLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: ControlWidth(-20)).isActive = true
    MenuLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor, constant: ControlX(20)).isActive = true
    MenuLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-40)).isActive = true
        
    ImageIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    ImageIcon.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    ImageIcon.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    ImageIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
