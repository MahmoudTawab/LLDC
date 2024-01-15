//
//  ِِAppAdvertisement.swift
//  LLDC
//
//  Created by Emojiios on 05/04/2022.
//

import UIKit
import SDWebImage

public enum EnumAdvertisement {
    case featuredEvents,shopsOffers
}

protocol AppAdvertisementDelegate {
    func featuredEvents(Index:IndexPath,id:Int)
    func shopsOffers(Index:IndexPath,id:Int)
}

class AppAdvertisement: UICollectionViewCell {

    var advertisement : EnumAdvertisement?
    var featuredEvents = [FeaturedEvents]() {
        didSet {
            AdvertisementCV.reloadData()
        }
    }
    
    var shopsOffers = [ShopsOffers]() {
        didSet {
            AdvertisementCV.reloadData()
        }
    }

    var Delegate:AppAdvertisementDelegate?
    lazy var AdvertisementLabel : UILabel = {
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
    
    let EventId = "Event"
    var itemWidth = CGFloat(0)
    let collectionMargin = CGFloat(0)
    let itemSpacing = ControlWidth(8)
    let itemHeight = ControlWidth(215)
    lazy var AdvertisementCV  : UICollectionView = {
        let layout: UICollectionViewFlowLayout = RTLCollectionViewFlowLayout()
        
        itemWidth = (UIScreen.main.bounds.width - ControlWidth(30)) - (collectionMargin + 10) * 2.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.delegate = self
        vc.dataSource = self
        vc.backgroundColor = .clear
        vc.collectionViewLayout = layout
        vc.showsHorizontalScrollIndicator = false
        vc.decelerationRate = UIScrollView.DecelerationRate.fast
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(AdvertisementCell.self, forCellWithReuseIdentifier: EventId)
        return vc
    }()

    lazy var pageControl:CHIPageControlPuya = {
        let pc = CHIPageControlPuya(frame: CGRect(x: 0, y:0, width: 100, height: 10))
        pc.delegate = self
        pc.tintColor = .black
        pc.enableTouchEvents = true
        pc.backgroundColor = .clear
        pc.currentPageTintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        pc.radius = 5
        pc.padding = 10
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.transform = CGAffineTransform(scaleX: ControlWidth(1), y: ControlWidth(1))
        return pc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.clipsToBounds = true
        self.layer.masksToBounds = true
        addSubview(AdvertisementLabel)
        addSubview(ImageIcon)
        addSubview(AdvertisementCV)
        addSubview(pageControl)
        
        AdvertisementLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        AdvertisementLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        AdvertisementLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(5)).isActive = true
        AdvertisementLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-30)).isActive = true
        
        ImageIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ImageIcon.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        ImageIcon.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        ImageIcon.centerYAnchor.constraint(equalTo: AdvertisementLabel.centerYAnchor).isActive = true
        
        AdvertisementCV.topAnchor.constraint(equalTo: AdvertisementLabel.bottomAnchor, constant: ControlX(10)).isActive = true
        AdvertisementCV.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        AdvertisementCV.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        AdvertisementCV.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        pageControl.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        pageControl.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pageControl.topAnchor.constraint(equalTo: AdvertisementCV.bottomAnchor, constant: ControlX(10)).isActive = true
        pageControl.transform = CGAffineTransform(rotationAngle: "lang".localizable == "ar" ? .pi:0)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppAdvertisement: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout , CHIBasePageControlDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch advertisement {
        case .featuredEvents:
        pageControl.numberOfPages = featuredEvents.count
        return featuredEvents.count
            
        case .shopsOffers:
        pageControl.numberOfPages = shopsOffers.count
        return shopsOffers.count
        default:
        return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventId,for: indexPath) as! AdvertisementCell
        cell.backgroundColor = .clear
        
        switch advertisement {
        case .featuredEvents:
        cell.EventsLabel.isHidden = false
        cell.EventsLabel.text = featuredEvents[indexPath.item].title
        cell.EventsImage.sd_setImage(with: URL(string: featuredEvents[indexPath.item].photoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            
        case .shopsOffers:
        cell.EventsLabel.isHidden = true
        cell.EventsImage.sd_setImage(with: URL(string: shopsOffers[indexPath.item].photoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        default:
        break
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch advertisement {
    case .featuredEvents:
    if let id = featuredEvents[indexPath.item].screenId {
    Delegate?.featuredEvents(Index:indexPath,id: id)
    }
        
    case .shopsOffers:
    if let id = shopsOffers[indexPath.item].screenId {
    Delegate?.shopsOffers(Index:indexPath,id: id)
    }
    default:
    break
    }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(AdvertisementCV.contentSize.width)
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.pageControl.set(progress: Int(newPage), animated: true)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
    

    func didTouch(pager: CHIBasePageControl, index: Int) {
    pageControl.set(progress: index, animated: false)
    AdvertisementCV.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
    }
    
}


