//
//  EventCell.swift
//  LLDC
//
//  Created by Emojiios on 03/04/2022.
//

import UIKit

protocol EventDelegate {
    func ActionShowEvent(_ Cell:EventCell)
}

class EventCell : UITableViewCell {

    var Delegate:EventDelegate?
    lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.layer.cornerRadius = ControlX(10)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
    return ImageView
    }()
    
    lazy var TitleLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.backgroundColor = #colorLiteral(red: 0.07388865203, green: 0.4815660715, blue: 0.5901879668, alpha: 1)
        View.IconImage.setImage(UIImage(named: ""), for: .normal)
        View.IconImage.layer.cornerRadius = ControlHeight(6)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(12))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(12))
        return View
    }()
    
    lazy var LocationLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "Location"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(13))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(10.5))
        return View
    }()
    
    lazy var TimeLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "clock"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(12))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(10.5))
        return View
    }()

    lazy var DateLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "calendar"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(12))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(14))
        return View
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TitleLabel,LocationLabel,TimeLabel,DateLabel])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(3)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()

    lazy var ShowButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1)
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "right-arrow"), for: .normal)
        Button.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        Button.addTarget(self, action: #selector(ActionShowEvent), for: .touchUpInside)
        return Button
    }()

    @objc func ActionShowEvent() {
    Delegate?.ActionShowEvent(self)
    }
    
    lazy var ViewLine:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        addSubview(ImageView)
        ImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(20)).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-15)).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(15)).isActive = true
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true

        addSubview(StackLabel)
        StackLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(20)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-15)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor, constant: ControlX(15)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-70)).isActive = true

        addSubview(ShowButton)
        ShowButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
        ShowButton.centerYAnchor.constraint(equalTo: StackLabel.centerYAnchor).isActive = true
        ShowButton.widthAnchor.constraint(equalToConstant: ControlWidth(46)).isActive = true
        ShowButton.heightAnchor.constraint(equalToConstant: ControlWidth(46)).isActive = true
        ShowButton.layer.cornerRadius = ControlX(23)
        
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



