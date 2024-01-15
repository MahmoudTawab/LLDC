//
//  EventsTableCell.swift
//  LLDC
//
//  Created by Emojiios on 13/06/2022.
//

import UIKit

class EventsTableCell: UITableViewCell {
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    
    lazy var DetailLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(16))
        return Label
    }()
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TitleLabel,DetailLabel])
        Stack.axis = .vertical
        Stack.spacing = ControlHeight(10)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(Stack)
        backgroundColor = .clear
        Stack.topAnchor.constraint(equalTo: self.topAnchor , constant: ControlX(10)).isActive = true
        Stack.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        Stack.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: ControlX(-15)).isActive = true
        Stack.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
