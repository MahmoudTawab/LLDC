//
//  RestaurantMenuCell.swift
//  LLDC
//
//  Created by Emojiios on 13/06/2022.
//

import UIKit

class RestaurantMenuCell: UICollectionViewCell {

    lazy var MenuTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1087588281, green: 0.1087588281, blue: 0.1087588281, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(16))
        return Label
    }()
    
    lazy var MenuDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(16))
        return Label
    }()
    
    lazy var MenuPrice : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1087588281, green: 0.1087588281, blue: 0.1087588281, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(16))
        return Label
    }()
    
    let MenuImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        contentView.addSubview(MenuImage)
        contentView.addSubview(MenuTitle)
        contentView.addSubview(MenuDetails)
        contentView.addSubview(MenuPrice)
        
        MenuImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        MenuImage.topAnchor.constraint(equalTo: self.topAnchor ,constant: ControlX(10)).isActive = true
        MenuImage.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-10)).isActive = true
        MenuImage.widthAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        MenuImage.layer.cornerRadius = ControlX(10)
        
        MenuTitle.leadingAnchor.constraint(equalTo: MenuImage.trailingAnchor , constant: ControlX(15)).isActive = true
        MenuTitle.topAnchor.constraint(equalTo: MenuImage.topAnchor,constant: ControlX(2)).isActive = true
        MenuTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: ControlX(-110)).isActive = true
        MenuTitle.heightAnchor.constraint(equalToConstant: ControlHeight(20)).isActive = true
        
        MenuDetails.leadingAnchor.constraint(equalTo: MenuTitle.leadingAnchor).isActive = true
        MenuDetails.trailingAnchor.constraint(equalTo: MenuTitle.trailingAnchor).isActive = true
        MenuDetails.heightAnchor.constraint(equalToConstant: ControlHeight(30)).isActive = true
        MenuDetails.topAnchor.constraint(equalTo: MenuTitle.bottomAnchor).isActive = true
        
        MenuPrice.leadingAnchor.constraint(equalTo: MenuTitle.leadingAnchor).isActive = true
        MenuPrice.bottomAnchor.constraint(equalTo: MenuImage.bottomAnchor,constant: ControlX(-2)).isActive = true
        MenuPrice.trailingAnchor.constraint(equalTo: MenuTitle.trailingAnchor).isActive = true
        MenuPrice.heightAnchor.constraint(equalTo: MenuTitle.heightAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RestaurantMenuHeader : UICollectionReusableView {
    
    lazy var RestaurantName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(RestaurantName)
        RestaurantName.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(8)).isActive = true
        RestaurantName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        RestaurantName.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        RestaurantName.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
