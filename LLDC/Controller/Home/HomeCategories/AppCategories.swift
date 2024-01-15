//
//  AppCategories.swift
//  LLDC
//
//  Created by Emojiios on 05/04/2022.
//

import UIKit
import SDWebImage

protocol CategoriesDelegate {
    func CategoriesSelect(_ indexPath:IndexPath)
}

class AppCategories: UICollectionViewCell {
        
    let CategoriesId = "Categories"
    var Delegate : CategoriesDelegate?
    var Categories = [TopCollection]() {
        didSet {
            ReservationsCategories.reloadData()
        }
    }
    
    lazy var ReservationsCategories: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesId)
        return vc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addSubview(ReservationsCategories)
        ReservationsCategories.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-5)).isActive = true
        ReservationsCategories.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ReservationsCategories.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ReservationsCategories.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppCategories : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {


func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Categories.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesId, for: indexPath) as! CategoriesCell
    cell.backgroundColor = #colorLiteral(red: 0.8994513154, green: 0.9072406292, blue: 0.8371486068, alpha: 1)
    cell.CategoriesLabel.text = Categories[indexPath.item].title
    cell.ImageView.sd_setImage(with: URL(string: Categories[indexPath.item].iconPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
    return cell
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height - ControlWidth(10))
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return ControlX(15)
}

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    Delegate?.CategoriesSelect(indexPath)
}
}
