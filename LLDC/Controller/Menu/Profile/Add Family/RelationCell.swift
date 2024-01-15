//
//  RelationCell.swift
//  LLDC
//
//  Created by Emojiios on 31/03/2022.
//

import UIKit

class RelationCell: UICollectionViewCell {

    lazy var RelationLabel : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(15))
        return Label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
       
    addSubview(RelationLabel)
    RelationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    RelationLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    RelationLabel.leadingAnchor.constraint(equalTo: leadingAnchor ,constant: ControlX(10)).isActive = true
    RelationLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: ControlX(-10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
