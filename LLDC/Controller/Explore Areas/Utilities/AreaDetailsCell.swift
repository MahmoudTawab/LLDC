//
//  AreaDetailsCell.swift
//  LLDC
//
//  Created by Emojiios on 08/05/2022.
//

import UIKit

class AreaDetailsCell : UICollectionViewCell {
    
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .white
        ImageView.contentMode = .scaleToFill
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(15))
        return Label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(ImageView)
        addSubview(LabelTitle)
        clipsToBounds = true
        layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowRadius = 5
        backgroundColor = .white
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.cornerRadius = ControlX(8)

        ImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-40)).isActive = true
        
        LabelTitle.topAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: ControlX(5)).isActive = true
        LabelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(8)).isActive = true
        LabelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-8)).isActive = true
        LabelTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-5)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
