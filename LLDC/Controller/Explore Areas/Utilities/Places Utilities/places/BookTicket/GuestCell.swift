//
//  GuestCell.swift
//  LLDC
//
//  Created by Emojiios on 04/04/2022.
//

import UIKit

protocol GuestCellDelegate {
    func ActionRemove(_ Cell:GuestCell)
}

class GuestCell : UICollectionViewCell {
    
    var Delegate:GuestCellDelegate?
    lazy var LabelSelected : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(19))
        return Label
    }()
    
    lazy var LabelName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(18))
        return Label
    }()
    
    lazy var LabelNumber : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1349771853, green: 0.1454147273, blue: 0.1600192929, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(18))
        return Label
    }()
    
    lazy var ButtonRemove : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.layer.borderColor = #colorLiteral(red: 0.1349771853, green: 0.1454147273, blue: 0.1600192929, alpha: 1)
        Button.contentEdgeInsets.bottom = 2
        Button.layer.borderWidth = ControlWidth(2)
        Button.layer.cornerRadius = ControlX(8)
        Button.setTitle("-".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionRemove), for: .touchUpInside)
        Button.titleLabel?.font = UIFont.systemFont(ofSize: ControlWidth(26), weight: .medium)
        Button.setTitleColor(#colorLiteral(red: 0.1349771853, green: 0.1454147273, blue: 0.1600192929, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionRemove() {
    Delegate?.ActionRemove(self)
    }

    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelName,LabelNumber])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .center
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    
    lazy var StackAll : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelSelected,Stack])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(StackAll)
        StackAll.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(10)).isActive = true
        StackAll.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-12)).isActive = true
        StackAll.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(15)).isActive = true
        StackAll.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-40)).isActive = true
        
        addSubview(ButtonRemove)
        ButtonRemove.centerYAnchor.constraint(equalTo: StackAll.arrangedSubviews[1].centerYAnchor).isActive = true
        ButtonRemove.widthAnchor.constraint(equalToConstant: ControlWidth(26)).isActive = true
        ButtonRemove.heightAnchor.constraint(equalToConstant: ControlWidth(26)).isActive = true
        ButtonRemove.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
