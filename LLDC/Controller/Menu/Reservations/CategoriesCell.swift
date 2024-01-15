//
//  CategoriesCell.swift
//  LLDC
//
//  Created by Emojiios on 03/04/2022.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
     lazy var CategoriesLabel : UILabel = {
       let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(15))
    return Label
    }()

    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.translatesAutoresizingMaskIntoConstraints = false
    return ImageView
    }()
    
    override init(frame: CGRect) {
    super.init(frame: frame)

    layer.shadowRadius = 4
    layer.shadowOpacity = 0.4
    backgroundColor = .white
    layer.shadowOffset = .zero
    layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
    layer.cornerRadius = ControlX(6)
        
    addSubview(CategoriesLabel)
    addSubview(ImageView)
    
    ImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(25)).isActive = true
    ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-50)).isActive = true
    ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(20)).isActive = true
    ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-20)).isActive = true
     
    CategoriesLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    CategoriesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-15)).isActive = true
    CategoriesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(10)).isActive = true
    CategoriesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
