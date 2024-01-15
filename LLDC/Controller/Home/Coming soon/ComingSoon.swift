//
//  ComingSoon.swift
//  LLDC
//
//  Created by Emojiios on 05/04/2022.
//

import UIKit
import SDWebImage

public enum EnumComingSoon {
    case foodBeverage,comingSoon
}

protocol ComingSoonDelegate {
    func foodBeverage(Index:IndexPath,id:Int)
    func comingSoon(Index:IndexPath,id:Int)
}

class ComingSoon: UICollectionViewCell {
    
    var ComingSoonEnum : EnumComingSoon?
    var Delegate:ComingSoonDelegate?
    var foodBeverage = [FoodBeverage]() {
        didSet {
            ComingSoonCollection.reloadData()
        }
    }
    
    var comingSoon = [ComingSoonData]() {
        didSet {
            ComingSoonCollection.reloadData()
        }
    }

    lazy var ComingSoonLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var ImageIcon : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.image = UIImage(named: "Path")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.transform = CGAffineTransform(rotationAngle: "lang".localizable == "ar" ? (.pi / 2):(-.pi / 2))
        return ImageView
    }()
    
    let ComingSoonId = "ComingSoon"
    lazy var ComingSoonCollection: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(ComingSoonCell.self, forCellWithReuseIdentifier: ComingSoonId)
        return vc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        addSubview(ImageIcon)
        addSubview(ComingSoonLabel)
        addSubview(ComingSoonCollection)
        
        ComingSoonLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ComingSoonLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ComingSoonLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        ComingSoonLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-30)).isActive = true
        
        ImageIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ImageIcon.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        ImageIcon.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        ImageIcon.centerYAnchor.constraint(equalTo: ComingSoonLabel.centerYAnchor).isActive = true
        
        ComingSoonCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ComingSoonCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ComingSoonCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ComingSoonCollection.topAnchor.constraint(equalTo: ComingSoonLabel.bottomAnchor, constant: ControlX(10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ComingSoon : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {


func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch ComingSoonEnum {
    case .foodBeverage:
    return foodBeverage.count
        
    case .comingSoon:
    return comingSoon.count
    default:
    return 0
    }
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComingSoonId, for: indexPath) as! ComingSoonCell

    
    switch ComingSoonEnum {
    case .foodBeverage:
    cell.LabelTitle.text = foodBeverage[indexPath.item].title
    cell.LocationLabel.TextLabel = foodBeverage[indexPath.item].location ?? ""
    cell.TimeLabel.TextLabel = "\(foodBeverage[indexPath.item].openingHoursFrom ?? "") - \(foodBeverage[indexPath.item].openingHoursTo ?? "")"
        cell.ImageView.sd_setImage(with: URL(string: foodBeverage[indexPath.item].photoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        
    case .comingSoon:
    cell.LabelTitle.text = comingSoon[indexPath.item].title
    cell.LocationLabel.TextLabel = comingSoon[indexPath.item].location ?? ""
    cell.TimeLabel.TextLabel = "\(comingSoon[indexPath.item].startTime ?? "")"
    cell.ImageView.sd_setImage(with: URL(string: comingSoon[indexPath.item].photoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
    default:
    break
    }
    
    return cell
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height - ControlWidth(10))
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return ControlX(15)
}

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch ComingSoonEnum {
    case .foodBeverage:
    if let id = foodBeverage[indexPath.item].screenId {
    Delegate?.foodBeverage(Index:indexPath,id: id)
    }
            
    case .comingSoon:
    if let id = comingSoon[indexPath.item].screenId {
    Delegate?.comingSoon(Index:indexPath,id: id)
    }
        
    default:
    break
    }
    

}
}
