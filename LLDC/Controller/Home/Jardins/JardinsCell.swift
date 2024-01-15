//
//  JardinsCell.swift
//  LLDC
//
//  Created by Emojiios on 05/04/2022.
//

import UIKit


class JardinsCell: UICollectionViewCell {
    
    lazy var JardinsLabel : UILabel = {
      let Label = UILabel()
       Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       Label.numberOfLines = 2
       Label.backgroundColor = .clear
       Label.translatesAutoresizingMaskIntoConstraints = false
       Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(17))
   return Label
   }()

   lazy var ImageView:UIImageView = {
       let ImageView = UIImageView()
       ImageView.clipsToBounds = true
       ImageView.backgroundColor = .clear
       ImageView.contentMode = .scaleAspectFill
       ImageView.translatesAutoresizingMaskIntoConstraints = false
   return ImageView
   }()
    
    var TopBackground:NSLayoutConstraint?
    var BottomBackground:NSLayoutConstraint?
    var BackgroundHeight1:NSLayoutConstraint?
    var BackgroundHeight2:NSLayoutConstraint?
    lazy var ViewBackground:UIView = {
        let View = UIView()
        View.layer.cornerRadius = ControlX(14)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

   override init(frame: CGRect) {
   super.init(frame: frame)
    backgroundColor = .clear
    clipsToBounds = true
    layer.cornerRadius = ControlX(16)
       
    addSubview(ViewBackground)
    ViewBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    ViewBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    ViewBackground.heightAnchor.constraint(equalTo: self.heightAnchor , constant: ControlX(-15)).isActive = true

    TopBackground = ViewBackground.topAnchor.constraint(equalTo: self.topAnchor)
    TopBackground?.isActive = true

    BottomBackground = ViewBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    BottomBackground?.isActive = false
       
    ViewBackground.addSubview(ImageView)
    ImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
    ImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2.2).isActive = true
    ImageView.topAnchor.constraint(equalTo: ViewBackground.topAnchor, constant: ControlX(15)).isActive = true
    ImageView.trailingAnchor.constraint(equalTo: ViewBackground.trailingAnchor, constant: ControlX(-10)).isActive = true
       
    ViewBackground.addSubview(JardinsLabel)
    JardinsLabel.topAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: ControlX(5)).isActive = true
    JardinsLabel.bottomAnchor.constraint(equalTo: ViewBackground.bottomAnchor,constant: ControlX(-5)).isActive = true
    JardinsLabel.leadingAnchor.constraint(equalTo: ViewBackground.leadingAnchor, constant: ControlX(10)).isActive = true
    JardinsLabel.trailingAnchor.constraint(equalTo: ViewBackground.trailingAnchor, constant: ControlX(-10)).isActive = true
       
//    addSubview(ImageView)
//    ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//    ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//
//    TopBackground = ImageView.topAnchor.constraint(equalTo: self.topAnchor)
//    TopBackground?.isActive = true
//
//    BottomBackground = ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//    BottomBackground?.isActive = false
//       
//    BackgroundHeight1 = ImageView.heightAnchor.constraint(equalTo: self.heightAnchor)
//    BackgroundHeight1?.isActive = true
//
//    BackgroundHeight2 = ImageView.heightAnchor.constraint(equalTo: self.heightAnchor , constant: ControlX(-15))
//    BackgroundHeight2?.isActive = false
//       
//    addSubview(JardinsLabel)
//    JardinsLabel.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
//    JardinsLabel.bottomAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: ControlX(-10)).isActive = true
//    JardinsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(10)).isActive = true
//    JardinsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-20)).isActive = true
       
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
}

