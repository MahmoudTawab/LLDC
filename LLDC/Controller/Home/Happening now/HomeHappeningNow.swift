//
//  HomeHappeningNow.swift
//  LLDC
//
//  Created by Emojiios on 05/04/2022.
//

import UIKit

protocol HomeHappeningNowDelegate {
    func HappeningNow(Index:IndexPath,id: Int)
}

class HomeHappeningNow: UICollectionViewCell {

    var Delegate:HomeHappeningNowDelegate?
    var foodBeveraget = [FoodBeverage]() {
        didSet {
            HappeningNowCV.reloadData()
        }
    }
    
    lazy var HappeningLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
        return Label
    }()
    
    let HappeningNowId = "HappeningNow"
    var itemWidth = CGFloat(0)
    let collectionMargin = CGFloat(0)
    let itemSpacing = ControlWidth(8)
    let itemHeight = ControlWidth(215)
    lazy var HappeningNowCV : UICollectionView = {
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
        vc.register(HappeningNowCell.self, forCellWithReuseIdentifier: HappeningNowId)
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
        backgroundColor = .clear

        self.clipsToBounds = true
        self.layer.masksToBounds = true
        addSubview(HappeningLabel)
        addSubview(HappeningNowCV)
        addSubview(pageControl)
        
        HappeningLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        HappeningLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        HappeningLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(5)).isActive = true
        HappeningLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-30)).isActive = true
        
        HappeningNowCV.topAnchor.constraint(equalTo: HappeningLabel.bottomAnchor, constant: ControlX(10)).isActive = true
        HappeningNowCV.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        HappeningNowCV.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        HappeningNowCV.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        pageControl.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pageControl.topAnchor.constraint(equalTo: HappeningNowCV.bottomAnchor, constant: ControlX(10)).isActive = true
        pageControl.transform = CGAffineTransform(rotationAngle: "lang".localizable == "ar" ? .pi:0)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeHappeningNow: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout , CHIBasePageControlDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = foodBeveraget.count
        return foodBeveraget.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HappeningNowId,for: indexPath) as! HappeningNowCell
        cell.backgroundColor = .clear
        
        cell.EventsName.text = foodBeveraget[indexPath.item].title
        cell.LocationLabel.TextLabel = foodBeveraget[indexPath.item].location ?? ""
        cell.HappeningImage.sd_setImage(with: URL(string: foodBeveraget[indexPath.item].photoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = foodBeveraget[indexPath.item].screenId {
        Delegate?.HappeningNow(Index:indexPath,id: id)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(HappeningNowCV.contentSize.width)
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
    HappeningNowCV.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
    }
    
}


