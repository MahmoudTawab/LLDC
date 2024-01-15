//
//  HeaderView.swift
//  LLDC
//
//  Created by Emojiios on 25/04/2022.
//

import UIKit

class HeaderView: UICollectionViewCell {
    
    lazy var imageView : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.contentMode = .scaleAspectFill
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var Title : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1774599552, green: 0.3385826945, blue: 0.4175281525, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(18))
        return Label
    }()
    
    lazy var ViewRating : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.contentHorizontalAlignment = .right
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "RatingSelected"), for: .normal)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Regular", size:  ControlWidth(13))
        return Button
    }()
    
    lazy var TitleAndRating : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Title,ViewRating])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Stack
    }()
    
    lazy var LocationLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "Location"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(10), height: ControlHeight(11))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(10.5))
        return View
    }()
    
    lazy var TimeLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "clock"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(11), height: ControlHeight(11))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(10.5))
        return View
    }()
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LocationLabel,TimeLabel])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Stack
    }()
    
    lazy var Details : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.5304390192, green: 0.5342428684, blue: 0.5381280184, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(15))
        return Label
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TitleAndRating,Stack,Details])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(2)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    self.clipsToBounds = false
    self.backgroundColor = .clear
    self.layer.masksToBounds = false
    self.addSubview(imageView)
    self.addSubview(StackLabel)
        

    self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(-15)).isActive = true
    self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(15)).isActive = true
    self.imageView.heightAnchor.constraint(equalToConstant: ControlWidth(265)).isActive = true
    
    self.StackLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: ControlX(10)).isActive = true
    self.StackLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    self.StackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    self.StackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-5)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
