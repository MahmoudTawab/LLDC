//
//  ReservationsFamilyCell.swift
//  LLDC
//
//  Created by Emojiios on 05/04/2022.
//

import UIKit

protocol AddFamilyDelegate {
    func AddFamily(_ Cell:ReservationsFamilyCell)
}

class ReservationsFamilyCell: UICollectionViewCell {
    
    var Delegate:AddFamilyDelegate?
    lazy var CheckboxButton : Checkbox = {
        let Button = Checkbox(type: .system)
        Button.Color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
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
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(14))
        return Label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(CheckboxButton)
        CheckboxButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        CheckboxButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(1)).isActive = true
        CheckboxButton.widthAnchor.constraint(equalToConstant: ControlWidth(34)).isActive = true
        CheckboxButton.heightAnchor.constraint(equalToConstant: ControlWidth(34)).isActive = true
        
        addSubview(ProfileImage)
        ProfileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ProfileImage.leadingAnchor.constraint(equalTo: CheckboxButton.trailingAnchor,constant: ControlX(5)).isActive = true
        ProfileImage.widthAnchor.constraint(equalToConstant: ControlWidth(34)).isActive = true
        ProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(34)).isActive = true
        ProfileImage.layer.cornerRadius = ControlX(17)
        
        addSubview(LabelName)
        LabelName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        LabelName.leadingAnchor.constraint(equalTo: ProfileImage.trailingAnchor,constant: ControlX(5)).isActive = true
        LabelName.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-5)).isActive = true
        LabelName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionHeader)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func ActionHeader() {
    Delegate?.AddFamily(self)
    }
    
}
