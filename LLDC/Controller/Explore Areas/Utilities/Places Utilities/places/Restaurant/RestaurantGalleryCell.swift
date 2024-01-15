//
//  RestaurantGalleryCell.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit

class RestaurantGalleryCell: UICollectionViewCell {
    
    lazy var RestaurantImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        return ImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.cornerRadius = ControlX(10)
        clipsToBounds = true
        
        addSubview(RestaurantImage)
        RestaurantImage.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
