//
//  NotificationSettingsCell.swift
//  LLDC
//
//  Created by Emojiios on 03/04/2022.
//

import UIKit

protocol NotificationSettingsDelegate {
    func SwitchUpdate(Cell:NotificationSettingsCell)
}

class NotificationSettingsCell: UITableViewCell {

    var Delegate:NotificationSettingsDelegate?
    
    lazy var Switch : UISwitch = {
    let Switch = UISwitch()
    Switch.translatesAutoresizingMaskIntoConstraints = false
    Switch.addTarget(self, action: #selector(Update), for: .valueChanged)
    return Switch
    }()
    
    @objc func Update() {
    Delegate?.SwitchUpdate(Cell: self)
    }
 
    lazy var TextTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var ViewLine:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        let StackView = UIStackView(arrangedSubviews: [TextTitle, Switch])
        StackView.axis = .horizontal
        StackView.distribution = .fillProportionally
        StackView.alignment = .fill
        StackView.spacing = ControlWidth(10)
        StackView.backgroundColor = .clear
        StackView.translatesAutoresizingMaskIntoConstraints = false
        StackView.arrangedSubviews[1].widthAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true

        addSubview(StackView)
        StackView.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(10)).isActive = true
        StackView.arrangedSubviews[0].heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        StackView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        StackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        StackView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-10)).isActive = true

        addSubview(ViewLine)
        ViewLine.heightAnchor.constraint(equalToConstant: ControlWidth(1)).isActive = true
        ViewLine.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        ViewLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        ViewLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        contentView.isHidden = true
    }

    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }

}


