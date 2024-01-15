//
//  PendingReviewsVC.swift
//  LLDC
//
//  Created by Emojiios on 03/04/2022.
//

import UIKit
import SDWebImage

class PendingReviewsVC: ViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, UtilitieDelegate {
    
    let ReviewsId = "Reviews"
    var PendingReviews = [Places]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        SetDataPendingReviews()
    }
    
    fileprivate func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Dismiss.TextLabel = "Pending Reviews".localizable
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
        view.addSubview(PendingReviewsCV)
        PendingReviewsCV.topAnchor.constraint(equalTo: Dismiss.bottomAnchor, constant: ControlY(10)).isActive = true
        PendingReviewsCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
        PendingReviewsCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        PendingReviewsCV.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    lazy var PendingReviewsCV: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        vc.dataSource = self
        vc.delegate = self
        vc.isHidden = true
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        vc.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        vc.addPullLoadableView(loadMoreView, type: .loadMore)
        
        vc.showsVerticalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(UtilitieCell.self, forCellWithReuseIdentifier: ReviewsId)
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        return vc
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PendingReviews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsId, for: indexPath) as! UtilitieCell
        
        if let rate = PendingReviews[indexPath.item].rate {
        cell.ViewRating.isHidden = false
        cell.ViewRating.setTitle("lang".localizable == "ar" ? "\(rate)".NumAR() : "\(rate)", for: .normal)
        }else{
        cell.ViewRating.isHidden = true
        }
        
        cell.Delegate = self
        cell.LabelTitle.text = PendingReviews[indexPath.item].placeName ?? ""
        cell.LocationLabel.TextLabel = PendingReviews[indexPath.item].areaName ?? ""
        cell.ImageView.sd_setImage(with: URL(string: PendingReviews[indexPath.item].coverPhotoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        cell.LocationLabel.IconImage.sd_setImage(with: URL(string: PendingReviews[indexPath.item].areaIcon ?? "") , for: .normal, placeholderImage: UIImage(named: "Location"))
        cell.DateLabel.IconImage.sd_setImage(with: URL(string: PendingReviews[indexPath.item].openingHoursIcon ?? "") , for: .normal, placeholderImage: UIImage(named: "clock"))
        cell.DateLabel.TextLabel = "\(PendingReviews[indexPath.item].startDate ?? "") \(PendingReviews[indexPath.item].openingHoursFrom ?? "")-\(PendingReviews[indexPath.item].openingHoursTo ?? "")"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - ControlX(8), height: ControlWidth(200))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ControlX(15)
    }
    
    func ActionSaved(Cell: UtilitieCell) {}
    func ActionRating(Cell: UtilitieCell) {
    if let index = PendingReviewsCV.indexPath(for: Cell) {
    let Reviews = ReviewsVC()
    Reviews.PlacesId = PendingReviews[index.item].id
    Present(ViewController: self, ToViewController: Reviews)
    }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let Reviews = PendingReviewsRating()
 
    Reviews.PlacesId = PendingReviews[indexPath.item].id
    Reviews.canEdit = PendingReviews[indexPath.item].Rate?.canEdit ?? false
    Reviews.TextView.text = PendingReviews[indexPath.item].Rate?.comment ?? ""
    Reviews.Rat.rating = Double(PendingReviews[indexPath.item].Rate?.rat ?? 5)
    Reviews.Organization.rating = Double(PendingReviews[indexPath.item].Rate?.organization ?? 5)
    Reviews.YourExperience.rating = Double(PendingReviews[indexPath.item].Rate?.yourExperience ?? 5)
        
    Reviews.LabelTitel.text = PendingReviews[indexPath.item].placeName ?? ""
    Reviews.LabelDetails.text = PendingReviews[indexPath.item].placeDescription ?? ""
    Reviews.ImageRating.sd_setImage(with: URL(string: PendingReviews[indexPath.item].coverPhotoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
    Reviews.DateLabel.IconImage.sd_setImage(with: URL(string: PendingReviews[indexPath.item].openingHoursIcon ?? "") , for: .normal, placeholderImage: UIImage(named: "clock"))
    Reviews.DateLabel.TextLabel = "\(PendingReviews[indexPath.item].startDate ?? "") - \(PendingReviews[indexPath.item].openingHoursFrom ?? "") - \(PendingReviews[indexPath.item].openingHoursTo ?? "")"
    Present(ViewController: self, ToViewController: Reviews)
    }
    
    var skip = 0
    var Animations = true
    var fetchingMore = false
    func SetDataPendingReviews(removeAll:Bool = false, ShowDots:Bool = true) {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//
//    let api = "\(url + GetPendingReviews)"
//    let sqlId = getProfileObject().sqlId ?? ""
//    let token = defaults.string(forKey: "jwt") ?? ""
//
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                    "Platform": "I",
//                                    "Lang": "lang".localizable,
//                                    "SqlId": sqlId,
//                                    "Take": 10,
//                                    "Skip": skip]
//        
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        
        let data = [
            ["id" :"","coverPhotoPath" : "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg","placeName" : "placeName","rate" : 3.5,"areaIcon" : "String","areaId" : 1
            ,"areaName" : "Area Name"
            ,"utilitieId" : 1
            ,"utilitieName" : "Utilitie Name"
            ,"openingHoursIcon" : ""
            ,"startDate" : "23/10"
            ,"openingHoursFrom" : "12:00 am"
            ,"openingHoursTo" : "10:30 pm"
            ,"isFavorite":true
            ,"screenId" : 1
            ,"screenName" : ""
            ,"subUtilitieId" : 1
            ,"subUtilitieName" : "sub Utilitie Name"
            ,"placeDescription" : "place Description"
            ,"Rate" :["id" : "","yourExperience" : 1,"organization" : 1,"rat" : 2.5,"comment" : "Comment String","canEdit" : true]],
        
         
         ["id" :"","coverPhotoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6N_xhIKNoKNkmzh_q4FQ703xnRO9IKrR1fgIxjkdIQ5wSb3tai7eO10JyypfpJ_g41gw&usqp=CAU","placeName" : "placeName","rate" : 4.0,"areaIcon" : "String","areaId" : 1
             ,"areaName" : "Area Name"
             ,"utilitieId" : 1
             ,"utilitieName" : "Utilitie Name"
             ,"openingHoursIcon" : ""
             ,"startDate" : "23/10"
             ,"openingHoursFrom" : "12:00 am"
             ,"openingHoursTo" : "10:30 pm"
             ,"isFavorite":true
             ,"screenId" : 1
             ,"screenName" : ""
             ,"subUtilitieId" : 1
             ,"subUtilitieName" : "sub Utilitie Name"
             ,"placeDescription" : "place Description"
             ,"Rate" :["id" : "","yourExperience" : 1,"organization" : 1,"rat" : 4.3,"comment" : "Comment String","canEdit" : true]],
         
            ["id" :"","coverPhotoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6N_xhIKNoKNkmzh_q4FQ703xnRO9IKrR1fgIxjkdIQ5wSb3tai7eO10JyypfpJ_g41gw&usqp=CAU","placeName" : "placeName","rate" : 5.0,"areaIcon" : "String","areaId" : 1
             ,"areaName" : "Area Name"
             ,"utilitieId" : 1
             ,"utilitieName" : "Utilitie Name"
             ,"openingHoursIcon" : ""
             ,"startDate" : "23/10"
             ,"openingHoursFrom" : "12:00 am"
             ,"openingHoursTo" : "10:30 pm"
             ,"isFavorite":true
             ,"screenId" : 1
             ,"screenName" : ""
             ,"subUtilitieId" : 1
             ,"subUtilitieName" : "sub Utilitie Name"
             ,"placeDescription" : "place Description"
             ,"Rate" :["id" : "","yourExperience" : 1,"organization" : 1,"rat" : 2.5,"comment" : "Comment String","canEdit" : true]],
         
         ["id" :"","coverPhotoPath" : "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg","placeName" : "placeName","rate" : 4.0,"areaIcon" : "String","areaId" : 1
             ,"areaName" : "Area Name"
             ,"utilitieId" : 1
             ,"utilitieName" : "Utilitie Name"
             ,"openingHoursIcon" : ""
             ,"startDate" : "23/10"
             ,"openingHoursFrom" : "12:00 am"
             ,"openingHoursTo" : "10:30 pm"
             ,"isFavorite":true
             ,"screenId" : 1
             ,"screenName" : ""
             ,"subUtilitieId" : 1
             ,"subUtilitieName" : "sub Utilitie Name"
             ,"placeDescription" : "place Description"
             ,"Rate" :["id" : "","yourExperience" : 1,"organization" : 1,"rat" : 4.5,"comment" : "Comment String","canEdit" : true]],
         
         ["id" :"","coverPhotoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6N_xhIKNoKNkmzh_q4FQ703xnRO9IKrR1fgIxjkdIQ5wSb3tai7eO10JyypfpJ_g41gw&usqp=CAU","placeName" : "placeName","rate" : 2.5,"areaIcon" : "String","areaId" : 1
             ,"areaName" : "Area Name"
             ,"utilitieId" : 1
             ,"utilitieName" : "Utilitie Name"
             ,"openingHoursIcon" : ""
             ,"startDate" : "23/10"
             ,"openingHoursFrom" : "12:00 am"
             ,"openingHoursTo" : "10:30 pm"
             ,"isFavorite":true
             ,"screenId" : 1
             ,"screenName" : ""
             ,"subUtilitieId" : 1
             ,"subUtilitieName" : "sub Utilitie Name"
             ,"placeDescription" : "place Description"
             ,"Rate" :["id" : "","yourExperience" : 1,"organization" : 1,"rat" : 4.5,"comment" : "Comment String","canEdit" : true]],
         
         ["id" :"","coverPhotoPath" : "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg","placeName" : "placeName","rate" : 3.5,"areaIcon" : "String","areaId" : 1
             ,"areaName" : "Area Name"
             ,"utilitieId" : 1
             ,"utilitieName" : "Utilitie Name"
             ,"openingHoursIcon" : ""
             ,"startDate" : "23/10"
             ,"openingHoursFrom" : "12:00 am"
             ,"openingHoursTo" : "10:30 pm"
             ,"isFavorite":true
             ,"screenId" : 1
             ,"screenName" : ""
             ,"subUtilitieId" : 1
             ,"subUtilitieName" : "sub Utilitie Name"
             ,"placeDescription" : "place Description"
             ,"Rate" :["id" : "","yourExperience" : 1,"organization" : 1,"rat" : 4.5,"comment" : "Comment String","canEdit" : true]]
        ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            if removeAll {
                self.PendingReviewsCV.RemoveAnimations {
                    self.PendingReviews.removeAll()
                    self.Animations = true
                    self.AddData(dictionary:data)
                }
            }else{
                self.AddData(dictionary:data)
            }
        }
                        
//    } Err: { error in
//    if self.PendingReviews.count != 0 {
//    return
//    }else{
//    self.IfNoData()
//    self.SetUpIsError(error,true) {self.refresh()}
//    }
//    }
    }
    
    @objc func refresh() {
    skip = 0
    SetDataPendingReviews(removeAll: true)
    }
    
    func AddData(dictionary:[[String:Any]]) {
    for item in dictionary {
    self.PendingReviews.append(Places(dictionary: item))
    self.skip += 1
    self.fetchingMore = false
    self.Animations == true ? self.PendingReviewsCV.SetAnimations() {self.Animations = false} : self.PendingReviewsCV.reloadData()
    }
    self.IfNoData()
    }
    
    func IfNoData() {
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    self.ViewNoData.isHidden = self.PendingReviews.count != 0 ? true : false
    self.PendingReviewsCV.isHidden = self.PendingReviews.count == 0 ? true : false
    self.ViewDots.endRefreshing(){}
    }
}


extension PendingReviewsVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.SetDataPendingReviews(removeAll: false, ShowDots: false)
        }
        default: break
        }
        return
        }

        switch state {
        case .none:
        pullLoadView.messageLabel.text = ""
        case .pulling(_, _):
        pullLoadView.messageLabel.text = "Pull more".localizable
        case let .loading(completionHandler):
        pullLoadView.messageLabel.text = "Updating".localizable
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.refresh()
        }
        }
        return
        }
}
