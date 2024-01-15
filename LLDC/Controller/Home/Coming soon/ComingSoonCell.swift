//
//  ComingSoonCell.swift
//  LLDC
//
//  Created by Emojiios on 06/04/2022.
//

import UIKit

class ComingSoonCell: UICollectionViewCell {
    
    lazy var ImageView : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.layer.cornerRadius = ControlX(6)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.119961385, green: 0.1292377823, blue: 0.1422176346, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(13))
        return Label
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
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelTitle,LocationLabel,TimeLabel])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(2)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ImageView)
        addSubview(StackLabel)
        backgroundColor = .clear
        
        ImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ImageView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 1/1.7).isActive = true
        
        StackLabel.topAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: ControlX(10)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
