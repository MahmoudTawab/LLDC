//
//  AreaDetailsTop.swift
//  LLDC
//
//  Created by Emojiios on 31/05/2022.
//

import UIKit
import SDWebImage

protocol AreaDetailsTopDelegate {
    func AreaDetailsTopSelect(_ indexPath:IndexPath)
}

class AreaDetailsTop: UICollectionViewCell {
    
    var Delegate:AreaDetailsTopDelegate?
    var TopData = [TopCall]() {
        didSet {
            TopCollection.reloadData()
        }
    }
    
    lazy var TopLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.text = "Top".localizable
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
        return Label
    }()

    
    let TopCellId = "TopCellId"
    lazy var TopCollection: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(15)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(AreaDetailsTopCell.self, forCellWithReuseIdentifier: TopCellId)
        vc.contentInset = UIEdgeInsets(top: 0, left: ControlX(5), bottom: 0, right: ControlX(5))
        return vc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(TopLabel)
        addSubview(TopCollection)
        
        TopLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        TopLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        TopLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        TopLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-30)).isActive = true
        
        TopCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        TopCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        TopCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        TopCollection.topAnchor.constraint(equalTo: TopLabel.bottomAnchor, constant: ControlX(10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AreaDetailsTop: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TopData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCellId,for: indexPath) as! AreaDetailsTopCell
        cell.layer.cornerRadius = ControlX(16)
        cell.LabelTitle.text = TopData[indexPath.item].title
        cell.ImageView.sd_setImage(with: URL(string: TopData[indexPath.item].coverPhotoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    Delegate?.AreaDetailsTopSelect(indexPath)
    }
    
}


class AreaDetailsTopCell: UICollectionViewCell {
    
    lazy var ImageView : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.layer.cornerRadius = ControlX(6)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.119961385, green: 0.1292377823, blue: 0.1422176346, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(13))
        return Label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ImageView)
        addSubview(LabelTitle)
        backgroundColor = .clear
        
        ImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-45)).isActive = true
        
        LabelTitle.topAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: ControlX(10)).isActive = true
        LabelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        LabelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        LabelTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
