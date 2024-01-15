//
//  FAQCell.swift
//  LLDC
//
//  Created by Emojiios on 02/04/2022.
//

import UIKit

class FAQCell : UITableViewCell {

    lazy var OpenClose : UIImageView = {
        let Image = UIImageView()
        Image.tintColor = #colorLiteral(red: 0.4317458444, green: 0.4317458444, blue: 0.4317458444, alpha: 1)
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Path")
        Image.contentMode = .scaleAspectFit
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
 
    lazy var TextTitle : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
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
    
    
    lazy var ViewLine:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        let childStackView = UIStackView(arrangedSubviews: [TextTitle, OpenClose])
        childStackView.axis = .horizontal
        childStackView.distribution = .fillProportionally
        childStackView.alignment = .bottom
        childStackView.spacing = ControlWidth(10)
        childStackView.backgroundColor = .clear
        childStackView.translatesAutoresizingMaskIntoConstraints = false
        childStackView.arrangedSubviews[1].widthAnchor.constraint(equalToConstant: ControlWidth(19)).isActive = true
        childStackView.arrangedSubviews[1].heightAnchor.constraint(equalToConstant: ControlWidth(19)).isActive = true

        let StackVertical = UIStackView(arrangedSubviews: [childStackView,TheDetails])
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


