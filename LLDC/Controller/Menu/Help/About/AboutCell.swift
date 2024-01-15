//
//  AboutCell.swift
//  Color
//
//  Created by Mahmoud Tawab on 6/2/20.
//  Copyright © 2020 Mahmoud Abd El Tawab. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell {

    lazy var TextTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()

    lazy var TheDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(16))
        return Label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        let StackVertical = UIStackView(arrangedSubviews: [TextTitle,TheDetails])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlWidth(20)
        StackVertical.backgroundColor = .clear
        StackVertical.distribution = .equalSpacing
        StackVertical.translatesAutoresizingMaskIntoConstraints = false

        addSubview(StackVertical)
        StackVertical.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(10)).isActive = true
        StackVertical.arrangedSubviews[0].heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        StackVertical.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        StackVertical.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        StackVertical.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-10)).isActive = true
        
        contentView.isHidden = true
    }

    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }

}
