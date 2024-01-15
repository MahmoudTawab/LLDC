//
//  EventsCollectionCell.swift
//  LLDC
//
//  Created by Emojiios on 13/06/2022.
//

import UIKit

class EventsCollectionCell: UICollectionViewCell {
    
    lazy var EventsImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        return ImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(EventsImage)
        EventsImage.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

