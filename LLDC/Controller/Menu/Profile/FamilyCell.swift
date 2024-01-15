//
//  FamilyCell.swift
//  LLDC
//
//  Created by Emojiios on 30/03/2022.
//

import UIKit

protocol FamilyCellDelegate {
    func ActionEdit(_ Cell:FamilyCell)
    func ActionRemove(_ Cell:FamilyCell)
}

class FamilyCell: UICollectionViewCell {
    
    var Delegate : FamilyCellDelegate?
    
    lazy var ProfileImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ImageView.backgroundColor = .clear
        ImageView.layer.masksToBounds = true
        ImageView.contentMode = .scaleAspectFill
        ImageView.image = UIImage(named: "Profile")
        ImageView.layer.borderWidth = ControlWidth(1)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var LabelName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(14))
        return Label
    }()
    
    lazy var LabelPhone : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(14))
        return Label
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelName,LabelPhone])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(2)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = #colorLiteral(red: 0.9558447003, green: 0.9558447003, blue: 0.9558447003, alpha: 1)
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var EditButton : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = .black
        ImageView.backgroundColor = UIColor.clear
        ImageView.image = UIImage(named: "edit")
        ImageView.isUserInteractionEnabled = true
        ImageView.contentMode = .scaleAspectFill
        ImageView.translatesAutoresizingMaskIntoConstraints = true
        ImageView.heightAnchor.constraint(equalToConstant: ControlWidth(27)).isActive = true
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(27)).isActive = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionEdit)))
        return ImageView
    }()
    
    @objc func ActionEdit() {
    Delegate?.ActionEdit(self)
    }
    
    lazy var ButtonRemove : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.layer.borderColor = #colorLiteral(red: 0.1349771853, green: 0.1454147273, blue: 0.1600192929, alpha: 1)
        Button.contentEdgeInsets.bottom = 2
        Button.layer.borderWidth = ControlWidth(1.5)
        Button.layer.cornerRadius = ControlX(8)
        Button.setTitle("-".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = true
        Button.addTarget(self, action: #selector(ActionRemove), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        Button.titleLabel?.font = UIFont.systemFont(ofSize: ControlWidth(26), weight: .medium)
        Button.setTitleColor(#colorLiteral(red: 0.1349771853, green: 0.1454147273, blue: 0.1600192929, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionRemove() {
    Delegate?.ActionRemove(self)
    }
    
    lazy var StackButton : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [EditButton,ButtonRemove])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(16)
        Stack.distribution = .equalSpacing
        Stack.alignment = .center
        Stack.backgroundColor = #colorLiteral(red: 0.9558447003, green: 0.9558447003, blue: 0.9558447003, alpha: 1)
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9558447003, green: 0.9558447003, blue: 0.9558447003, alpha: 1)
        
        addSubview(ProfileImage)
        ProfileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ProfileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        ProfileImage.widthAnchor.constraint(equalToConstant: ControlWidth(36)).isActive = true
        ProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(36)).isActive = true
        ProfileImage.layer.cornerRadius = ControlX(18)
        
        addSubview(StackLabel)
        StackLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: ProfileImage.trailingAnchor,constant: ControlX(10)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-90)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(StackButton)
        StackButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        StackButton.leadingAnchor.constraint(equalTo: StackLabel.trailingAnchor,constant: ControlX(5)).isActive = true
        StackButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
        StackButton.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
