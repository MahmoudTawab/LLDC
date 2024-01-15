//
//  RetailOffersCell.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit

class RetailOffersCell: UICollectionViewCell {
    
    lazy var RetailImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        return ImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.cornerRadius = ControlX(15)
        clipsToBounds = true
        
        addSubview(RetailImage)
        RetailImage.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
