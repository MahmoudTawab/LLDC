//
//  SearchItemVC.swift
//  LLDC
//
//  Created by Emojiios on 05/07/2022.
//

import UIKit
import SDWebImage

class SearchItemVC: ViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    let SearchId = "Search"
    var keyWord: String?
    var keyWordId: String?
    var SearchPlaces = [Places]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        SetDataSearchItem()
    }
    
    fileprivate func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Dismiss.TextLabel = "Search".localizable
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
        view.addSubview(SearchResults)
        SearchResults.topAnchor.constraint(equalTo: Dismiss.bottomAnchor, constant: ControlY(10)).isActive = true
        SearchResults.leftAnchor.constraint(equalTo: view.leftAnchor,constant: ControlX(15)).isActive = true
        SearchResults.rightAnchor.constraint(equalTo: view.rightAnchor,constant: ControlX(-15)).isActive = true
        SearchResults.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
        view.addSubview(SavedCollection)
        SavedCollection.topAnchor.constraint(equalTo: SearchResults.bottomAnchor, constant: ControlY(10)).isActive = true
        SavedCollection.leadingAnchor.constraint(equalTo: SearchResults.leadingAnchor).isActive = true
        SavedCollection.trailingAnchor.constraint(equalTo: SearchResults.trailingAnchor).isActive = true
        SavedCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    lazy var SearchResults : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Search Results".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()

    lazy var SavedCollection: CollectionAnimations = {
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
        vc.register(UtilitieCell.self, forCellWithReuseIdentifier: SearchId)
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(10), right: 0)
        return vc
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SearchPlaces.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchId, for: indexPath) as! UtilitieCell
        cell.SavedIcon.isHidden = true
        
        if let rate = SearchPlaces[indexPath.item].rate {
        cell.ViewRating.isHidden = false
        cell.ViewRating.setTitle("lang".localizable == "ar" ? "\(rate)".NumAR() : "\(rate)", for: .normal)
        }else{
        cell.ViewRating.isHidden = true
        }
        
        cell.LabelTitle.text = SearchPlaces[indexPath.item].placeName ?? ""
        cell.LocationLabel.TextLabel = SearchPlaces[indexPath.item].areaName ?? ""
        cell.ImageView.sd_setImage(with: URL(string: SearchPlaces[indexPath.item].coverPhotoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        cell.LocationLabel.IconImage.sd_setImage(with: URL(string: SearchPlaces[indexPath.item].areaIcon ?? "") , for: .normal, placeholderImage: UIImage(named: "Location"))
        cell.DateLabel.IconImage.sd_setImage(with: URL(string: SearchPlaces[indexPath.item].openingHoursIcon ?? "") , for: .normal, placeholderImage: UIImage(named: "clock"))
        cell.DateLabel.TextLabel = "\(SearchPlaces[indexPath.item].startDate ?? "") \(SearchPlaces[indexPath.item].openingHoursFrom ?? "")-\(SearchPlaces[indexPath.item].openingHoursTo ?? "")"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - ControlX(8), height: ControlWidth(200))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ControlX(15)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch SearchPlaces[indexPath.item].screenId {
        case 1:
        let Restaurant = RestaurantVC()
        Restaurant.AreaId = SearchPlaces[indexPath.item].id
        Present(ViewController: self, ToViewController: Restaurant)
        case 2:
        let Retail = RetailVC()
        Retail.AreaId = SearchPlaces[indexPath.item].id
        Present(ViewController: self, ToViewController: Retail)
        case 3:
        let Events = EventsVC()
        Events.AreaId = SearchPlaces[indexPath.item].id
        Present(ViewController: self, ToViewController: Events)
        case 4:
        let Library = LibraryVC()
        Library.AreaId = SearchPlaces[indexPath.item].id
        Present(ViewController: self, ToViewController: Library)
        case 5:
        let Museum = MuseumVC()
        Museum.AreaId = SearchPlaces[indexPath.item].id
        Present(ViewController: self, ToViewController: Museum)
        case 6:
        let Corporate = CorporateVC()
        Corporate.AreaId = SearchPlaces[indexPath.item].id
        Present(ViewController: self, ToViewController: Corporate)
        default:
        break
        }
    }
    
//    func ActionSaved(Cell: UtilitieCell) {
//    if let index = SavedCollection.indexPath(for: Cell) {
//    let UrlAddOrRemove = self.SearchPlaces[index.item].isFavorite == false ? AddFavoritePlaces : RemoveFavoritePlaces
//
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let api = "\(url + UrlAddOrRemove)"
//
//    guard let PlacesId = SearchPlaces[index.item].id else{return}
//    let sqlId = getProfileObject().sqlId ?? ""
//
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                    "Platform": "I",
//                                    "placesId": PlacesId,
//                                    "SqlId": sqlId]
//
//    self.ViewDots.beginRefreshing()
//    Cell.SavedIcon.isUserInteractionEnabled = false
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//
//    self.ViewDots.endRefreshing {}
//    self.SearchPlaces[index.item].isFavorite == false ? Cell.SavedIcon.setImage(UIImage(named: "Saved"), for: .normal): Cell.SavedIcon.setImage(UIImage(named: "NotSaved"), for: .normal)
//    self.SearchPlaces[index.item].isFavorite = !(self.SearchPlaces[index.item].isFavorite ?? false)
//    Cell.SavedIcon.isUserInteractionEnabled = true
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { _ in
//    } Err: { Error in
//    self.ViewDots.endRefreshing(Error, .error) {}
//    Cell.SavedIcon.isUserInteractionEnabled = true
//    }
//    }
//    }
    
    func ActionRating(Cell: UtilitieCell) {
    if let index = SavedCollection.indexPath(for: Cell) {
    let Reviews = ReviewsVC()
    Reviews.PlacesId = SearchPlaces[index.item].id
    Present(ViewController: self, ToViewController: Reviews)
    }
    }

    
    var skip = 0
    var Animations = true
    var fetchingMore = false
    func SetDataSearchItem(removeAll:Bool = false, ShowDots:Bool = true) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    let sqlId = getProfileObject().sqlId ?? ""
    guard let keyWord = keyWord else{return}

    let keyWordId = keyWordId ?? ""
    let api = "\(url + GetSearchResult)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                    "Platform": "I",
                                    "Lang": "lang".localizable,
                                    "SqlId": sqlId,
                                    "keyWord": keyWord,
                                    "keyWordId": keyWordId,
                                    "deviceId": udid,
                                    "Take": 10,
                                    "Skip": skip]

    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [
        ["id" :"","coverPhotoPath" : "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg","placeName" : "placeName","rate" : 4.5,"areaIcon" : "String","areaId" : 1
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
        
         
         ["id" :"","coverPhotoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6N_xhIKNoKNkmzh_q4FQ703xnRO9IKrR1fgIxjkdIQ5wSb3tai7eO10JyypfpJ_g41gw&usqp=CAU","placeName" : "placeName","rate" : 4.5,"areaIcon" : "String","areaId" : 1
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
         
         ["id" :"","coverPhotoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6N_xhIKNoKNkmzh_q4FQ703xnRO9IKrR1fgIxjkdIQ5wSb3tai7eO10JyypfpJ_g41gw&usqp=CAU","placeName" : "placeName","rate" : 4.5,"areaIcon" : "String","areaId" : 1
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
         
         ["id" :"","coverPhotoPath" : "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg","placeName" : "placeName","rate" : 4.5,"areaIcon" : "String","areaId" : 1
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
         
         ["id" :"","coverPhotoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6N_xhIKNoKNkmzh_q4FQ703xnRO9IKrR1fgIxjkdIQ5wSb3tai7eO10JyypfpJ_g41gw&usqp=CAU","placeName" : "placeName","rate" : 4.5,"areaIcon" : "String","areaId" : 1
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
         
         ["id" :"","coverPhotoPath" : "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg","placeName" : "placeName","rate" : 4.5,"areaIcon" : "String","areaId" : 1
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
                self.SavedCollection.RemoveAnimations {
                    self.SearchPlaces.removeAll()
                    self.Animations = true
                    self.AddData(dictionary:data)
                }
            }else{
                self.AddData(dictionary:data)
            }
        }
                        
//    } Err: { error in
//    if self.SearchPlaces.count != 0 {
//    return
//    }else{
//    self.IfNoData()
//    self.SetUpIsError(error,true) {self.refresh()}
//    }
//    }
    }
    
    @objc func refresh() {
    skip = 0
    SetDataSearchItem(removeAll: true)
    }
    
    func AddData(dictionary:[[String:Any]]) {
    for item in dictionary {
    self.SearchPlaces.append(Places(dictionary: item))
    self.skip += 1
    self.fetchingMore = false
    self.Animations == true ? self.SavedCollection.SetAnimations() {self.Animations = false} : self.SavedCollection.reloadData()
    }
    self.IfNoData()
    }
    
    func IfNoData() {
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    self.ViewNoData.isHidden = self.SearchPlaces.count != 0 ? true : false
    self.SavedCollection.isHidden = self.SearchPlaces.count == 0 ? true : false
    self.ViewDots.endRefreshing(){}
    }
}


extension SearchItemVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.SetDataSearchItem(removeAll: false, ShowDots: false)
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
