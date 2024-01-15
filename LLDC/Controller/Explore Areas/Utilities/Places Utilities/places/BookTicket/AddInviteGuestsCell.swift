//
//  AddInviteGuestsCell.swift
//  LLDC
//
//  Created by Emojiios on 19/06/2022.
//


import UIKit

protocol AddGuestsDelegate {
    func AddGuests(_ Cell:AddInviteGuestsCell)
}

class AddInviteGuestsCell: UICollectionViewCell {
   
    var Delegate:AddGuestsDelegate?
    lazy var AddInviteGuests : UIButton = {
       let Button = UIButton(type: .system)
       Button.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
       Button.backgroundColor = .clear
       Button.translatesAutoresizingMaskIntoConstraints = false
       Button.setTitle("Invite guests".localizable, for: .normal)
       Button.addTarget(self, action: #selector(ActionHeader), for: .touchUpInside)
       Button.contentHorizontalAlignment = "lang".localizable == "ar" ? .right : .left
       Button.titleLabel?.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
       Button.setImage(UIImage(named: "add")?.withInset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)), for: .normal)
       Button.setTitleColor(#colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1), for: .normal)
       return Button
   }()
    
    @objc func ActionHeader() {
    Delegate?.AddGuests(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(AddInviteGuests)
        AddInviteGuests.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        AddInviteGuests.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        AddInviteGuests.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        AddInviteGuests.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
