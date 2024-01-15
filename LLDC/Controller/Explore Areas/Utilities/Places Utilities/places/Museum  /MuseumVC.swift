//
//  MuseumVC.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit
import SDWebImage

public enum MuseumType {
    case About,Gallery
}

class MuseumVC : ViewController , TwicketSegmentedControlDelegate {
    
    var AreaId : String?
    var thumbs = [Media]()
    var mediaArray = [Media]()
    var Details:PlaceDetails?
    var imageArray = [UIImage]()
    var EnumMuseum:MuseumType?
    var headerHeightConstraint: NSLayoutConstraint!
    let maxHeaderHeight: CGFloat = ControlHeight(300)
    let minHeaderHeight: CGFloat = ControlHeight(140)
    var previousScrollOffset: CGFloat = 0
    var previousScrollViewHeight: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9414902329, green: 0.9350261092, blue: 0.9038181305, alpha: 1)
        SetUp()
        SetDataMuseum()
        EnumMuseum = "lang".localizable == "ar" ? .Gallery : .About
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    headerHeightConstraint.constant = maxHeaderHeight
    updateHeader()
    }
    
    fileprivate func SetUp() {
            
    view.addSubview(ViewTop)
    headerHeightConstraint = ViewTop.heightAnchor.constraint(equalToConstant: ControlHeight(300))
    headerHeightConstraint?.isActive = true
    ViewTop.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    ViewTop.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    ViewTop.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    ViewTop.addSubview(MuseumImage)
    MuseumImage.topAnchor.constraint(equalTo: ViewTop.topAnchor).isActive = true
    MuseumImage.leadingAnchor.constraint(equalTo: ViewTop.leadingAnchor).isActive = true
    MuseumImage.trailingAnchor.constraint(equalTo: ViewTop.trailingAnchor).isActive = true
    MuseumImage.bottomAnchor.constraint(equalTo: ViewTop.bottomAnchor , constant: ControlHeight(-110)).isActive = true
        
    ViewTop.addSubview(MuseumName)
    MuseumName.topAnchor.constraint(equalTo: MuseumImage.bottomAnchor,constant: ControlX(15)).isActive = true
    MuseumName.leadingAnchor.constraint(equalTo: ViewTop.leadingAnchor,constant: ControlX(15)).isActive = true
    MuseumName.widthAnchor.constraint(equalToConstant: ControlWidth(160)).isActive = true
    MuseumName.heightAnchor.constraint(equalToConstant: ControlHeight(28)).isActive = true
        
    ViewTop.addSubview(ViewRating)
    ViewRating.layer.cornerRadius = ControlHeight(14)
    ViewRating.topAnchor.constraint(equalTo: MuseumName.topAnchor).isActive = true
    ViewRating.bottomAnchor.constraint(equalTo: MuseumName.bottomAnchor).isActive = true
    ViewRating.leadingAnchor.constraint(equalTo: MuseumName.trailingAnchor,constant: ControlX(5)).isActive = true
    ViewRating.widthAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
    
    ViewTop.addSubview(SavedButton)
    SavedButton.bottomAnchor.constraint(equalTo: MuseumImage.bottomAnchor,constant: ControlY(20)).isActive = true
    SavedButton.trailingAnchor.constraint(equalTo: ViewTop.trailingAnchor,constant: ControlX(-15)).isActive = true
    SavedButton.widthAnchor.constraint(equalToConstant: ControlHeight(40)).isActive = true
    SavedButton.heightAnchor.constraint(equalToConstant: ControlHeight(40)).isActive = true
    SavedButton.layer.cornerRadius = ControlHeight(20)
        
    ViewTop.addSubview(SegmentedControl)
    SegmentedControl.topAnchor.constraint(equalTo: MuseumName.bottomAnchor,constant: ControlX(10)).isActive = true
    SegmentedControl.leadingAnchor.constraint(equalTo: ViewTop.leadingAnchor,constant: ControlX(5)).isActive = true
    SegmentedControl.trailingAnchor.constraint(equalTo: ViewTop.trailingAnchor,constant: ControlX(-5)).isActive = true
    SegmentedControl.heightAnchor.constraint(equalToConstant: ControlHeight(30)).isActive = true
        
    view.addSubview(MuseumCollection)
    MuseumCollection.topAnchor.constraint(equalTo: ViewTop.bottomAnchor).isActive = true
    MuseumCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
    MuseumCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-15)).isActive = true
    MuseumCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                
    view.addSubview(Dismiss)
    Dismiss.Label.alpha = 0
    Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.IconImage.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        defer {
        self.previousScrollViewHeight = scrollView.contentSize.height
        self.previousScrollOffset = scrollView.contentOffset.y
        }

        let heightDiff = scrollView.contentSize.height - self.previousScrollViewHeight
        let scrollDiff = (scrollView.contentOffset.y - self.previousScrollOffset)

        guard heightDiff == 0 else {
        self.expandHeader()
        return
        }

        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;

        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom

        if canAnimateHeader(scrollView) {
        var newHeight = self.headerHeightConstraint.constant
        if isScrollingDown {
        newHeight = max(self.minHeaderHeight, self.headerHeightConstraint.constant - abs(scrollDiff))
        } else if isScrollingUp {
        newHeight = min(self.maxHeaderHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
        }
        if newHeight != self.headerHeightConstraint.constant {
        self.headerHeightConstraint.constant = newHeight
        self.updateHeader()
        self.setScrollPosition(self.previousScrollOffset)
        }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidStopScrolling()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
    }

    func scrollViewDidStopScrolling() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let midPoint = self.minHeaderHeight + (range / 2)

        if self.headerHeightConstraint.constant > midPoint {
            self.expandHeader()
        } else {
            self.collapseHeader()
        }
    }

    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollViewMaxHeight
    }

    func collapseHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }

    func expandHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }

    func setScrollPosition(_ position: CGFloat) {
        self.MuseumCollection.contentOffset = CGPoint(x: self.MuseumCollection.contentOffset.x, y: position)
    }
    
    func updateHeader() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let openAmount = self.headerHeightConstraint.constant - self.minHeaderHeight
        let percentage = openAmount / range
        
        Dismiss.Label.alpha = abs(percentage - 1)
        self.MuseumName.alpha = percentage
        self.MuseumImage.alpha = percentage
        self.ViewRating.alpha = percentage
        self.SavedButton.alpha = percentage
    }
    
    ///
    lazy var ViewTop: UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.isHidden = true
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var MuseumImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var MuseumName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var ViewRating : UIButton = {
        let Button = UIButton(type: .system)
        Button.isHidden = true
        Button.backgroundColor = #colorLiteral(red: 0.9409350157, green: 0.9002719522, blue: 0.8440292478, alpha: 1)
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "RatingSelected"), for: .normal)
        Button.addTarget(self, action: #selector(ActionReviews), for: .touchUpInside)
        Button.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Regular", size:  ControlWidth(13))
        return Button
    }()
    
    
    @objc func ActionReviews() {
        let Reviews = ReviewsVC()
        Reviews.PlacesId = self.Details?.id
        Present(ViewController: self, ToViewController: Reviews)
    }
    
    lazy var SavedButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        Button.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        Button.layer.shadowOffset = .zero
        Button.layer.shadowOpacity = 0.4
        Button.layer.shadowRadius = 4
        Button.setImage(UIImage(named: "Saved")?.withInset(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSaved), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSaved() {
        let UrlAddOrRemove = self.Details?.isFavorite == false ? AddFavoritePlaces : RemoveFavoritePlaces
                
        guard let url = defaults.string(forKey: "API") else{
        LodBaseUrl()
        ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
        return
        }
        guard let placesId = AreaId else{return}

        let api = "\(url + UrlAddOrRemove)"
        let sqlId = getProfileObject().sqlId ?? ""
        let token = defaults.string(forKey: "jwt") ?? ""

        let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                        "Platform": "I",
                                        "placesId": placesId,
                                        "SqlId": sqlId]

        self.ViewDots.beginRefreshing()
        SavedButton.isUserInteractionEnabled = false
        PostAPI(api: api, token: token, parameters: parameters) { _ in
            
        self.ViewDots.endRefreshing {}
        self.Details?.isFavorite == false ? self.SavedButton.setImage(UIImage(named: "Saved")?.withInset(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)), for: .normal): self.SavedButton.setImage(UIImage(named: "NotSaved"), for: .normal)
        self.Details?.isFavorite = !(self.Details?.isFavorite ?? false)
        self.SavedButton.isUserInteractionEnabled = true
        } DictionaryData: { _ in
        } ArrayOfDictionary: { _ in
        } Err: { Error in
        self.ViewDots.endRefreshing(Error, .error) {}
        self.SavedButton.isUserInteractionEnabled = true
        }
    }
    
    lazy var SegmentedControl:TwicketSegmentedControl = {
        let View = TwicketSegmentedControl(frame: CGRect(x: ControlX(15), y: 0, width: view.frame.width - ControlX(30), height: ControlHeight(30)))
        View.setSegmentItems(["About".localizable, "Gallery".localizable])
        View.backgroundColor = .clear
        View.delegate = self
        View.translatesAutoresizingMaskIntoConstraints = false
        View.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16))
        return View
    }()
    
    func didSelect(_ segmentIndex: String) {
    if segmentIndex == "About".localizable && self.EnumMuseum != .About {
    self.EnumMuseum = .About
    }else if segmentIndex == "Gallery".localizable && self.EnumMuseum != .Gallery {
    self.EnumMuseum = .Gallery
    }else{
    return
    }
        
    UIView.animate(withDuration: 0.3, delay: 0, options: []) {
    self.MuseumCollection.alpha = 0
    } completion: { (_) in
    self.MuseumCollection.alpha = 1
    self.MuseumCollection.SetAnimations()
    }
        
    }
    
    var AboutId = "AboutId"
    var GalleryId = "GalleryId"
    lazy var MuseumCollection: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ControlWidth(5)
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.isHidden = true
        vc.showsVerticalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(10), right: 0)
        vc.register(MuseumAboutCell.self, forCellWithReuseIdentifier: AboutId)
        vc.register(MuseumGalleryCell.self, forCellWithReuseIdentifier: GalleryId)
        return vc
    }()

    
    func IfNoData() {
    self.ViewTop.isHidden = Details != nil ? false : true
    self.ViewNoData.isHidden = Details != nil ? true : false
    self.MuseumCollection.isHidden = Details != nil ? false : true
    self.MuseumCollection.SetAnimations()
    self.ViewDots.endRefreshing {}
    }


}

extension MuseumVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,MuseumAboutDelegate ,MediaBrowserDelegate {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if EnumMuseum == .About {
        return 1
        }else{
        return imageArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if EnumMuseum == .About {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutId, for: indexPath) as! MuseumAboutCell
            
        cell.Delegate = self
        cell.DateLabel.TextLabel = "\(Details?.openingHoursFrom ?? "") - \(Details?.openingHoursTo ?? "")" 
        cell.LocationLabel.TextLabel = Details?.areaName ?? ""
        cell.DetailsLabel.text = Details?.about ?? ""
        cell.DetailsLabel.addInterlineSpacing(spacingValue: ControlHeight(4))
        return cell
        }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryId, for: indexPath) as! MuseumGalleryCell
        cell.MuseumImage.image = imageArray[indexPath.item]
        return cell
        }
    }
    
    func BookTicket(Cell: MuseumAboutCell) {
    let BooK = BookVC()
    BooK.placesId = AreaId
    InviteGuestsSelected.IdSelect.removeAll()
    InviteGuestsSelected.Image.removeAll()
    InviteGuestsSelected.Guests.removeAll()
    BooK.Total = self.Details?.bookingFee ?? 0.0
    BooK.openingHoursTo = self.Details?.openingHoursTo
    BooK.openingHoursFrom = self.Details?.openingHoursFrom
    Present(ViewController: self, ToViewController: BooK)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if EnumMuseum == .About {
        let estimatedFrame = Details?.about?.TextHeight(collectionView.frame.width, font: UIFont.systemFont(ofSize: ControlWidth(15)), Spacing: ControlHeight(4)) ?? 0
        return CGSize(width: collectionView.frame.width , height: estimatedFrame + ControlWidth(90))
        }else{
        return CGSize(width: (collectionView.frame.width / 2) - ControlWidth(5), height: ControlWidth(220))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ControlX(15)
    }
    
    @objc func SetDataMuseum() {
        //    guard let url = defaults.string(forKey: "API") else{
        //    LodBaseUrl()
        //    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
        //    return
        //    }
        //    guard let placesId = AreaId else{return}
        //
        //    let api = "\(url + GetPlaceDetails)"
        //    let sqlId = getProfileObject().sqlId ?? ""
        //    let token = defaults.string(forKey: "jwt") ?? ""
        //
        //    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
        //                                    "Platform": "I",
        //                                    "Lang": "lang".localizable,
        //                                    "PlacesId": placesId,
        //                                    "SqlId": sqlId]
        //
            self.ViewDots.beginRefreshing()
        //    PostAPI(api: api, token: token, parameters: parameters) { _ in
        //    } DictionaryData: { data in
        
        let data = ["id":"","screenId":1,"screenName":"","isFavorite":true,"coverPhotoPath":"https://onepagelove.imgix.net/2022/06/opl-screenshot-5.jpg?w=540&max-h=540&fit=crop&fp-y=0&auto=compress","title":"Test String","rate":3.5
                             ,"areaName":"Area Name"
                             ,"subUtilitie":"sub Utilitie"
                             ,"about":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world "
                             ,"openingHoursFrom":"12:30"
                             ,"openingHoursTo":"05:30"
                             ,"startDate":"23/10"
                             ,"bookingFee":3.4
                             ,"bookingSta":true,
                     
                     "schedule":["id":"","startDate":"23/10","openingHoursFrom":"12:30","openingHoursTo":"05:30","bookingFee":3.6,"availableTickets":1],
                     "offers":[["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"]],
                     
                     "gallery":[["mediaType":"","mediaPath":"https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg"],
                                ["mediaType":"","mediaPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHg9QPgX1Ugi49mFFsYcWSrsJhRjRYScGyjWLZZUl4UrSvu4MoGrCrWYqWgaiLYV9w5aA&usqp=CAU"],
                                ["mediaType":"","mediaPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAK92MyGos-U-fuF8VLWE530y7FuULP9yr4GCmJ_laIMvwX4HVa7XvcP8wo2BaIlpUtDI&usqp=CAU"],
                                ["mediaType":"","mediaPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHg9QPgX1Ugi49mFFsYcWSrsJhRjRYScGyjWLZZUl4UrSvu4MoGrCrWYqWgaiLYV9w5aA&usqp=CAU"],
                                ["mediaType":"","mediaPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAK92MyGos-U-fuF8VLWE530y7FuULP9yr4GCmJ_laIMvwX4HVa7XvcP8wo2BaIlpUtDI&usqp=CAU"],
                                ["mediaType":"","mediaPath":"https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg"],
                                ["mediaType":"","mediaPath":"https://t3.ftcdn.net/jpg/03/24/73/92/360_F_324739203_keeq8udvv0P2h1MLYJ0GLSlTBagoXS48.jpg"],
                                ["mediaType":"","mediaPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAK92MyGos-U-fuF8VLWE530y7FuULP9yr4GCmJ_laIMvwX4HVa7XvcP8wo2BaIlpUtDI&usqp=CAU"],
                                ["mediaType":"","mediaPath":"https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg"]],
                     
                     "menu":[
                        
                        ["menuCategoryId":1,"menuCategory":"Mombar","details":
                                [["photoPath":"https://radifarms.com/wp-content/uploads/2022/07/DSC_5629-scaled.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://radifarms.com/wp-content/uploads/2022/07/DSC_5629-scaled.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://radifarms.com/wp-content/uploads/2022/07/DSC_5629-scaled.jpg","price":3343.4,"title":"Test String","about":"About String"]]
                                ],
                        
                             ["menuCategoryId":1,"menuCategory":"Charcoal Grilled Chicken","details":
                                [["photoPath":"https://www.simplyrecipes.com/thmb/m1LB58rp40jNA5L7_6O3IJkj4Cc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Grilled-BBQ-Chicken-LEAD-10-03fd9892eaae4ce1a8a3f4c949657cfd.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://www.simplyrecipes.com/thmb/m1LB58rp40jNA5L7_6O3IJkj4Cc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Grilled-BBQ-Chicken-LEAD-10-03fd9892eaae4ce1a8a3f4c949657cfd.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://www.simplyrecipes.com/thmb/m1LB58rp40jNA5L7_6O3IJkj4Cc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Grilled-BBQ-Chicken-LEAD-10-03fd9892eaae4ce1a8a3f4c949657cfd.jpg","price":3343.4,"title":"Test String","about":"About String"]]
                                ],
                     
                             ["menuCategoryId":1,"menuCategory":"Stuffed Pigeon with Rice or Fereek","details":[["photoPath":"https://as1.ftcdn.net/v2/jpg/05/70/58/38/1000_F_570583820_jOIu0YGJQY8iZIVRWrsdVDPZ234EPFGX.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                ["photoPath":"https://as1.ftcdn.net/v2/jpg/05/70/58/38/1000_F_570583820_jOIu0YGJQY8iZIVRWrsdVDPZ234EPFGX.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                ["photoPath":"https://as1.ftcdn.net/v2/jpg/05/70/58/38/1000_F_570583820_jOIu0YGJQY8iZIVRWrsdVDPZ234EPFGX.jpg","price":3343.4,"title":"Test String","about":"About String"]]
                                ],
                     
                             ["menuCategoryId":1,"menuCategory":"Whole Charcoal Grilled Chicken","details":
                                [["photoPath":"https://homecookingmemories.com/wp-content/uploads/2012/07/Grilled-BBQ-Whole-Chicken-Butterflying-Spatchcocked-7.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://homecookingmemories.com/wp-content/uploads/2012/07/Grilled-BBQ-Whole-Chicken-Butterflying-Spatchcocked-7.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://homecookingmemories.com/wp-content/uploads/2012/07/Grilled-BBQ-Whole-Chicken-Butterflying-Spatchcocked-7.jpg","price":3343.4,"title":"Test String","about":"About String"]]
                                ],
        
        
                             ["menuCategoryId":1,"menuCategory":"Vine Leaves","details":
                                [["photoPath":"https://ichef.bbci.co.uk/food/ic/food_16x9_832/recipes/dolmades_72399_16x9.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://ichef.bbci.co.uk/food/ic/food_16x9_832/recipes/dolmades_72399_16x9.jpg","price":3343.4,"title":"Test String","about":"About String"]]
                                ],
        
                             ["menuCategoryId":1,"menuCategory":"Grilled Chicken Fillet","details":
                                [["photoPath":"https://assets.epicurious.com/photos/629e61c3c8fc75488633ba7d/1:1/w_4102,h_4102,c_limit/GrilledChickenBreast_RECIPE_052522_34925.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://assets.epicurious.com/photos/629e61c3c8fc75488633ba7d/1:1/w_4102,h_4102,c_limit/GrilledChickenBreast_RECIPE_052522_34925.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://assets.epicurious.com/photos/629e61c3c8fc75488633ba7d/1:1/w_4102,h_4102,c_limit/GrilledChickenBreast_RECIPE_052522_34925.jpg","price":3343.4,"title":"Test String","about":"About String"]]
                                ]
                        
                             ]] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            
        self.Details = PlaceDetails(dictionary: data)
        self.Dismiss.TextLabel = self.Details?.title ?? "Museum"
        self.MuseumName.text = self.Details?.title ?? "Museum"
        self.MuseumImage.sd_setImage(with: URL(string: self.Details?.coverPhotoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        self.Details?.isFavorite == true ? self.SavedButton.setImage(UIImage(named: "Saved")?.withInset(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)), for: .normal): self.SavedButton.setImage(UIImage(named: "NotSaved"), for: .normal)
        
        if self.Details?.rate != 0 {
            if let rate = self.Details?.rate {
                self.ViewRating.isHidden = false
                self.ViewRating.setTitle("lang".localizable == "ar" ? " \(rate) ".NumAR() : " \(rate) ", for: .normal)
            }else{
                self.ViewRating.isHidden = true
            }
        }
        
        if let Gallery = self.Details?.Gallery {
            for item in Gallery {
                SDWebImageManager.shared.loadImage(with: URL(string: item.mediaPath ?? ""), progress: nil) { image, _, error, _, _, _ in
                    if let Image = image {
                        self.imageArray.append(Image)
                        self.MuseumCollection.reloadData()
                    }else{
                        self.imageArray.append(UIImage(named: "Group 26056") ?? UIImage())
                        self.MuseumCollection.reloadData()
                    }
                }
            }
        }
        
        self.MuseumCollection.reloadData()
        self.IfNoData()
    }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.IfNoData()
//    self.SetUpIsError(error, true) {
//    self.SetDataMuseum()
//    }
//    }
    }

    
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
        return imageArray.count
    }
    
    func thumbnail(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    for image in imageArray {
    let Image = Media(image: image, caption: self.Details?.title ?? "Museum")
    thumbs.append(Image)
    }
    return thumbs[index]
    }

    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    for image in imageArray {
    let Image = Media(image: image, caption: self.Details?.title ?? "Museum")
    mediaArray.append(Image)
    }
    return mediaArray[index]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if EnumMuseum == .Gallery {
    let browser = MediaBrowser(delegate: self)
    browser.setCurrentIndex(at: indexPath.item)
    browser.displayMediaNavigationArrows = true
    let nc = UINavigationController(rootViewController: browser)
    nc.modalPresentationStyle = .fullScreen
    nc.modalTransitionStyle = .coverVertical
    present(nc, animated: true)
    }
    }
}
