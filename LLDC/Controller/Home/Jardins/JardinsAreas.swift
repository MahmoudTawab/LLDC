//
//  JardinsAreas.swift
//  LLDC
//
//  Created by Emojiios on 05/04/2022.
//

import UIKit
import SDWebImage

protocol JardinsDelegate {
    func JardinsSelect(_ indexPath:IndexPath)
}

class JardinsAreas: UICollectionViewCell {
    
    var Delegate:JardinsDelegate?
    
    var JardinsData = [Jardins]() {
        didSet {
            JardinsCollection.reloadData()
        }
    }

    lazy var JardinsLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
        return Label
    }()

    
    let JardinsId = "Jardins"
    lazy var JardinsCollection: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(15)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(JardinsCell.self, forCellWithReuseIdentifier: JardinsId)
        vc.contentInset = UIEdgeInsets(top: 0, left: ControlX(5), bottom: 0, right: ControlX(5))
        return vc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(JardinsLabel)
        addSubview(JardinsCollection)
        
        JardinsLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        JardinsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        JardinsLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        JardinsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-30)).isActive = true
        
        JardinsCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        JardinsCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        JardinsCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-5)).isActive = true
        JardinsCollection.topAnchor.constraint(equalTo: JardinsLabel.bottomAnchor, constant: ControlX(10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JardinsAreas: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return JardinsData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JardinsId,for: indexPath) as! JardinsCell
        cell.BackgroundHeight1?.isActive = true
        cell.BackgroundHeight2?.isActive = false
        cell.JardinsLabel.text = JardinsData[indexPath.item].title
        cell.ViewBackground.backgroundColor = JardinsData[indexPath.item].background?.hexStringToUIColor()
        cell.ImageView.sd_setImage(with: URL(string: JardinsData[indexPath.item].iconPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    Delegate?.JardinsSelect(indexPath)
    }
    
}



