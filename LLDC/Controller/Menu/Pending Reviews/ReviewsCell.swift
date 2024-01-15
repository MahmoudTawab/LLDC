//
//  ReviewsCell.swift
//  LLDC
//
//  Created by Emojiios on 16/06/2022.
//

import UIKit

class ReviewsCell: UITableViewCell {

    lazy var NameLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(18))
        return Label
    }()
    
    lazy var CommentLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(16))
        return Label
    }()
    
    lazy var DateLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.IconImage.setImage(UIImage(named: "calendar"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(15), height: ControlHeight(15))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(15))
        View.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return View
    }()
    
    let ProfileImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .clear
        ImageView.layer.masksToBounds = true
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.borderWidth = ControlHeight(0.5)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.layer.borderColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1).cgColor
        return ImageView
    }()
    
    lazy var ViewRating : CosmosView = {
        let view = CosmosView()
        view.settings.filledImage = #imageLiteral(resourceName: "RatingSelected").withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = UIImage(named: "Reviews")
        view.settings.fillMode = .full
        view.settings.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.settings.textMargin = 10
        view.settings.starSize = 18
        view.settings.updateOnTouch = false
        return view
    }()
    
    lazy var NameRating : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [NameLabel,ViewRating])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Stack
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [NameRating,CommentLabel,DateLabel])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(ProfileImage)
        addSubview(StackLabel)
        
        ProfileImage.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(10)).isActive = true
        ProfileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        ProfileImage.widthAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        ProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        ProfileImage.layer.cornerRadius = ControlX(30)
        
        StackLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(10)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: ProfileImage.trailingAnchor , constant:ControlX(15)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: ControlX(-20)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-10)).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
