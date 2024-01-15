//
//  ImageAndLabel.swift
//  ImageAndLabel
//
//  Created by Emoji Technology on 22/09/2021.
//

import UIKit

class ImageAndLabel: UIView {

    @IBInspectable var TextLabel:String = "" {
      didSet {
          Label.text = TextLabel
      }
    }
    
    var IconImageWidth:NSLayoutConstraint!
    var IconImageHeight:NSLayoutConstraint!
    @IBInspectable var IconSize:CGSize = CGSize(width: ControlHeight(38), height: ControlHeight(38)) {
      didSet {
          IconImageWidth.constant = IconSize.width
          IconImageHeight.constant = IconSize.height
          self.layoutIfNeeded()
      }
    }
    
    lazy var IconImage : UIButton = {
        let ImageView = UIButton()
        let image = UIImage(named: "right-arrow")
        ImageView.setImage(image, for: .normal)
        ImageView.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        ImageView.backgroundColor = .clear
        ImageView.layer.masksToBounds = true
        ImageView.contentMode = .scaleAspectFill
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.textColor = .black
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(20))
        return Label
    }()

    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(IconImage)
        IconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        IconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        IconImageWidth = IconImage.widthAnchor.constraint(equalToConstant: ControlHeight(38))
        IconImageWidth?.isActive = true
        
        IconImageHeight = IconImage.heightAnchor.constraint(equalToConstant: ControlHeight(38))
        IconImageHeight?.isActive = true

        addSubview(Label)
        Label.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(3)).isActive = true
        Label.leadingAnchor.constraint(equalTo: IconImage.trailingAnchor, constant: ControlX(5)).isActive = true
        Label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlY(-3)).isActive = true
        Label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
