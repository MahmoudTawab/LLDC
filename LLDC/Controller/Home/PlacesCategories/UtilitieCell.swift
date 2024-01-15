//
//  Utilitie.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 27/07/2021.
//

import UIKit

protocol UtilitieDelegate {
    func ActionSaved(Cell:UtilitieCell)
    func ActionRating(Cell:UtilitieCell)
}

class UtilitieCell: UICollectionViewCell {
    
    var Delegate:UtilitieDelegate?
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
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(14.5))
        return Label
    }()
    
    lazy var ViewRating : UIButton = {
        let Button = UIButton(type: .system)
        Button.isHidden = true
        Button.backgroundColor = .clear
        Button.contentHorizontalAlignment = .right
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "RatingSelected"), for: .normal)
        Button.addTarget(self, action: #selector(ActionRating), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(32)).isActive = true
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Regular", size:  ControlWidth(13))
        return Button
    }()
    
    @objc func ActionRating() {
    Delegate?.ActionRating(Cell: self)
    }
    
    lazy var TitleAndRating : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelTitle,ViewRating])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
        
    lazy var LocationLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "Location"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(10), height: ControlHeight(11))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(10.5))
        return View
    }()
    
    lazy var DateLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "clock"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(11), height: ControlHeight(11))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(10.5))
        return View
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TitleAndRating,LocationLabel,DateLabel])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(1.5)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var SavedIcon : UIButton = {
        let Button = UIButton(type: .system)
        Button.isHidden = true
        Button.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSaved), for: .touchUpInside)
        Button.setImage(UIImage(named: "Saved")?.withInset(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)), for: .normal)
        return Button
    }()
    
    @objc func ActionSaved() {
    Delegate?.ActionSaved(Cell: self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(ImageView)
        addSubview(StackLabel)
        addSubview(SavedIcon)
        
        clipsToBounds = true
        layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowRadius = 5
        backgroundColor = .white
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.cornerRadius = ControlX(8)
        SavedIcon.layer.cornerRadius = ControlWidth(20)
        
        ImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ImageView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 1/1.8).isActive = true
        
        StackLabel.topAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: ControlX(8)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(8)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-8)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-8)).isActive = true
        
        SavedIcon.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(10)).isActive = true
        SavedIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-10)).isActive = true
        SavedIcon.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        SavedIcon.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
