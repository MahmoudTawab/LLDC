//
//  HappeningNowCell.swift
//  LLDC
//
//  Created by Emojiios on 06/07/2022.
//

import UIKit

class HappeningNowCell : UICollectionViewCell {

    lazy var ViewBackground:UIView = {
     let View = UIView()
     View.clipsToBounds = true
     View.backgroundColor = .white
     View.layer.cornerRadius = ControlX(6)
     View.translatesAutoresizingMaskIntoConstraints = false
    return View
    }()

    lazy var HappeningImage : UIImageView = {
     let ImageView = UIImageView()
     ImageView.clipsToBounds = true
     ImageView.backgroundColor = .clear
     ImageView.translatesAutoresizingMaskIntoConstraints = false
     return ImageView
    }()

    var EventsName : UILabel = {
     let Label = UILabel()
     Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
     Label.backgroundColor = .clear
     Label.translatesAutoresizingMaskIntoConstraints = false
     Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(17))
    return Label
    }()


    lazy var LocationLabel : ImageAndLabel = {
      let View = ImageAndLabel()
     View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
     View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
     View.backgroundColor = .clear
     View.translatesAutoresizingMaskIntoConstraints = false
     View.IconImage.setImage(UIImage(named: "Location"), for: .normal)
     View.IconSize = CGSize(width: ControlHeight(14), height: ControlHeight(15))
     View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(13))
     return View
   }()
    
    lazy var ImageIcon : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.image = UIImage(named: "Path")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        ImageView.transform = CGAffineTransform(rotationAngle: "lang".localizable == "ar" ? (.pi / 2):(-.pi / 2))
        return ImageView
    }()

    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [EventsName,LocationLabel])
        Stack.axis = .vertical
        Stack.spacing = ControlX(5)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [StackLabel,ImageIcon])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()

    override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .clear
            
        addSubview(ViewBackground)
        ViewBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ViewBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ViewBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ViewBackground.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            
        ViewBackground.addSubview(HappeningImage)
        HappeningImage.topAnchor.constraint(equalTo: ViewBackground.topAnchor).isActive = true
        HappeningImage.leadingAnchor.constraint(equalTo: ViewBackground.leadingAnchor).isActive = true
        HappeningImage.trailingAnchor.constraint(equalTo: ViewBackground.trailingAnchor).isActive = true
        HappeningImage.bottomAnchor.constraint(equalTo: ViewBackground.bottomAnchor, constant: ControlX(-70)).isActive = true
       
        ViewBackground.addSubview(Stack)
        Stack.topAnchor.constraint(equalTo: HappeningImage.bottomAnchor,constant: ControlX(10)).isActive = true
        Stack.leadingAnchor.constraint(equalTo: ViewBackground.leadingAnchor,constant: ControlX(15)).isActive = true
        Stack.trailingAnchor.constraint(equalTo: ViewBackground.trailingAnchor,constant: ControlX(-15)).isActive = true
        Stack.bottomAnchor.constraint(equalTo: self.bottomAnchor ,constant: ControlX(-10)).isActive = true
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
