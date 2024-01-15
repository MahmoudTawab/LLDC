//
//  AdvertisementCell.swift
//  LLDC
//
//  Created by Emojiios on 05/04/2022.
//

import UIKit

class AdvertisementCell: UICollectionViewCell {
    
    lazy var EventsImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.layer.cornerRadius = ControlX(6)
        return ImageView
    }()
    
    lazy var EventsLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.07910282096, green: 0.07910282096, blue: 0.07910282096, alpha: 1)
        Label.backgroundColor = .white
        Label.textAlignment = .center
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(EventsImage)
        EventsImage.frame = self.bounds
        
        EventsImage.addSubview(EventsLabel)
        let height = EventsLabel.text?.textSizeWithFont(UIFont.systemFont(ofSize: ControlWidth(25))).width ?? self.frame.width / 2
        EventsLabel.frame = CGRect(x: 0, y: self.frame.height - ControlWidth(40), width: height , height: ControlWidth(40))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
