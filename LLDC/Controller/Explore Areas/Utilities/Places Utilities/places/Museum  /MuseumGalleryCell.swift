//
//  MuseumGalleryCell.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit

class MuseumGalleryCell: UICollectionViewCell {
    
    lazy var MuseumImage : UIImageView = {
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
        
        addSubview(MuseumImage)
        MuseumImage.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
