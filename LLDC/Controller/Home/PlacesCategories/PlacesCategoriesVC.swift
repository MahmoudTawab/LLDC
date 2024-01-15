//
//  PlacesCategoriesVC.swift
//  LLDC
//
//  Created by Emojiios on 01/06/2022.
//

import UIKit
import SDWebImage

class PlacesCategoriesVC: ViewController {

    var Id : Int?
    var skip = 0
    var Animations = true
    var fetchingMore = false
    var places = [Places]()
    var UtilitieData = [Utilitie]()
    var PlacesData : PlacesCategories?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        GetPlaces()
        SetUpItems()
    }

    fileprivate func SetUpItems() {
    
    view.addSubview(Dismiss)
    Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(45), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
        
    view.addSubview(UtilitieTF)
    UtilitieTF.frame = CGRect(x: ControlX(20), y: Dismiss.frame.maxY + ControlY(20), width: view.frame.width - ControlX(120), height: ControlWidth(40))
       
    view.addSubview(UtilitieLabel)
    UtilitieLabel.frame = CGRect(x: view.frame.maxX - ControlWidth(90), y: UtilitieTF.frame.minY, width: ControlWidth(80), height: ControlWidth(40))
        
    view.addSubview(UtilitieCollection)
    UtilitieCollection.frame = CGRect(x: ControlX(15), y: UtilitieTF.frame.maxY + ControlY(20), width: view.frame.width - ControlX(30), height: view.frame.height - ControlHeight(150))
    }
    
    lazy var UtilitieTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tf.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)
        tf.ShowError = false
        tf.isHidden = true
        tf.text = "All".localizable
        tf.IconImage = UIImage(named: "Path")
        tf.translatesAutoresizingMaskIntoConstraints = true
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        tf.addTarget(self, action: #selector(ActionUtilitie), for: .editingDidBegin)
        tf.Icon.addTarget(self, action: #selector(ActionUtilitie), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionUtilitie)))
        return tf
    }()

    lazy var UtilitieLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.isHidden = true
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.text = "Utilitie".localizable
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
        return Label
    }()
    
    let PopUp = PopUpDownView()
   @objc func ActionUtilitie() {
        if UtilitieData.count != 0 {
        let height = CGFloat(UtilitieData.count) * ControlWidth(50)
        let Height = height < view.frame.height - 150 ? height:view.frame.height - 150
        let NewHeight = Height < ControlWidth(160) ? ControlWidth(160):Height
            
        PopUp.currentState = .open
        PopUp.modalPresentationStyle = .overFullScreen
        PopUp.modalTransitionStyle = .coverVertical
        PopUp.endCardHeight = NewHeight
        PopUp.View.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        PopUp.radius = 15

        let TopView = UIView()
        TopView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        PopUp.View.addSubview(TopView)
        TopView.frame = CGRect(x: PopUp.view.center.x - ControlWidth(60), y: ControlX(20), width: ControlWidth(120), height: ControlWidth(5))

        PopUp.View.addSubview(UtilitieTable)
        UtilitieTable.topAnchor.constraint(equalTo: PopUp.View.topAnchor, constant: ControlX(40)).isActive = true
        UtilitieTable.leftAnchor.constraint(equalTo: PopUp.View.leftAnchor).isActive = true
        UtilitieTable.rightAnchor.constraint(equalTo: PopUp.View.rightAnchor).isActive = true
        UtilitieTable.heightAnchor.constraint(equalToConstant: NewHeight - ControlX(40)).isActive = true
        UtilitieTable.SetAnimations()
        present(PopUp, animated: true)
       }
    }
    
    let cellId = "cellId"
    var SelectUtilitie = IndexPath(item: 0, section: 0)
    lazy var UtilitieTable : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.rowHeight = ControlWidth(50)
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        return tv
    }()
    
    var IdUtilitie : Int = 0
    var UtilitieId = "UtilitieId"
    lazy var UtilitieCollection: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ControlX(15)
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
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
        vc.register(UtilitieCell.self, forCellWithReuseIdentifier: UtilitieId)
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(10), right: 0)
        return vc
    }()
    
    @objc func refresh() {
    skip = 0
    GetPlaces(removeAll: true)
    }
    
    func IfNoData() {
    self.UtilitieCollection.isHidden = PlacesData != nil ? false : true
    self.UtilitieTF.isHidden = PlacesData != nil ? false : true
    self.UtilitieLabel.isHidden = PlacesData != nil ? false : true
    self.ViewNoData.isHidden = PlacesData != nil ? true : false
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(GetPlaces), for: .touchUpInside)
    }
}


extension PlacesCategoriesVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UtilitieData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = UtilitieData[indexPath.row].title
        
        cell.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        cell.backgroundColor = SelectUtilitie == indexPath ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : .white
        cell.accessoryType = SelectUtilitie == indexPath ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    skip = 0
    PopUp.DismissAction()
    if IdUtilitie != UtilitieData[indexPath.row].id ?? 0 {
    IdUtilitie = UtilitieData[indexPath.row].id ?? 0
    UtilitieTF.text = UtilitieData[indexPath.row].title
    GetPlaces(UtilitiesId: UtilitieData[indexPath.row].id ?? 0, removeAll: true)
    SelectUtilitie = indexPath
    tableView.reloadData()
    }
    }
        
}


extension PlacesCategoriesVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, UtilitieDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UtilitieId, for: indexPath) as! UtilitieCell
        cell.Delegate = self
        cell.LabelTitle.text = places[indexPath.item].placeName
        cell.LocationLabel.TextLabel = places[indexPath.item].areaName ?? ""
                
         if let rate = places[indexPath.item].rate {
        cell.ViewRating.isHidden = false
        cell.ViewRating.setTitle("lang".localizable == "ar" ? "\(rate)".NumAR() : "\(rate)", for: .normal)
        }else{
        cell.ViewRating.isHidden = true
        }
        
        cell.ImageView.sd_setImage(with: URL(string: places[indexPath.item].coverPhotoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        
        cell.LocationLabel.IconImage.sd_setImage(with: URL(string: places[indexPath.item].areaIcon ?? "") , for: .normal, placeholderImage: UIImage(named: "Location"))

        cell.DateLabel.IconImage.sd_setImage(with: URL(string: places[indexPath.item].openingHoursIcon ?? "") , for: .normal, placeholderImage: UIImage(named: "clock"))
        
        cell.DateLabel.TextLabel = "\(places[indexPath.item].startDate ?? "") \(places[indexPath.item].openingHoursFrom ?? "")-\(places[indexPath.item].openingHoursTo ?? "")"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - ControlX(8), height: ControlWidth(200))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch places[indexPath.item].screenId {
        case 1:
        let Restaurant = RestaurantVC()
        Restaurant.AreaId = places[indexPath.item].id
        Present(ViewController: self, ToViewController: Restaurant)
        case 2:
        let Retail = RetailVC()
        Retail.AreaId = places[indexPath.item].id
        Present(ViewController: self, ToViewController: Retail)
        case 3:
        let Events = EventsVC()
        Events.AreaId = places[indexPath.item].id
        Present(ViewController: self, ToViewController: Events)
        case 4:
        let Library = LibraryVC()
        Library.AreaId = places[indexPath.item].id
        Present(ViewController: self, ToViewController: Library)
        case 5:
        let Museum = MuseumVC()
        Museum.AreaId = places[indexPath.item].id
        Present(ViewController: self, ToViewController: Museum)
        case 6:
        let Corporate = CorporateVC()
        Corporate.AreaId = places[indexPath.item].id
        Present(ViewController: self, ToViewController: Corporate)
        default:
        break
        }
    }
    
    func ActionSaved(Cell: UtilitieCell) {}
    func ActionRating(Cell: UtilitieCell) {
    if let index = UtilitieCollection.indexPath(for: Cell) {
    let Reviews = ReviewsVC()
    Reviews.PlacesId = places[index.item].id
    Present(ViewController: self, ToViewController: Reviews)
    }
    }
    
    
    @objc func GetPlaces(UtilitiesId:Int = 0 ,removeAll:Bool = false, ShowDots:Bool = true) {
//    guard let id = Id else{return}
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let api = "\(url + GetPlacesCategories)"
//        
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                   "Platform": "I",
//                                   "CategoryId": id,
//                                   "UtilitiesId": UtilitiesId,
//                                   "Lang": "lang".localizable,
//                                   "Skip":skip,
//                                   "Take": 20]
        
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = [ "places": [
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
                                              
                    ,"utilitie":
                    [["id":1,"title":"Test 1","rate":4.2,"body":"body String","coverPhotoPath":"https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg"],
                    ["id":1,"title":"Test 2","rate":4.2,"body":"body String","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6N_xhIKNoKNkmzh_q4FQ703xnRO9IKrR1fgIxjkdIQ5wSb3tai7eO10JyypfpJ_g41gw&usqp=CAU"],
                    ["id":1,"title":"Test 3","rate":4.2,"body":"body String","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6N_xhIKNoKNkmzh_q4FQ703xnRO9IKrR1fgIxjkdIQ5wSb3tai7eO10JyypfpJ_g41gw&usqp=CAU"],
                    ["id":1,"title":"Test 4","rate":4.2,"body":"body String","coverPhotoPath":"https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg"],
                    ["id":1,"title":"Test 5","rate":4.0,"body":"body String","coverPhotoPath":"https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg"],
                    ["id":1,"title":"Test 6","rate":3.5,"body":"body String","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6N_xhIKNoKNkmzh_q4FQ703xnRO9IKrR1fgIxjkdIQ5wSb3tai7eO10JyypfpJ_g41gw&usqp=CAU"],
                     ["id":1,"title":"Test 7","rate":4.2,"body":"body String","coverPhotoPath":"https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg"]]
        ] as [String : Any]
        
        
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            if removeAll {
                self.UtilitieCollection.RemoveAnimations {
                    self.places.removeAll()
                    self.Animations = true
                    self.AddData(Data:data)
                }
            }else{
                self.AddData(Data:data)
            }
            
            self.ViewDots.endRefreshing {}
        }
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if self.places.count != 0 {
//    return
//    }else{
//    self.IfNoData()
//    self.SetUpIsError(error,true) {self.GetPlaces()}
//    }
//    }
    }
    
    func AddData(Data:[String:Any]) {
    self.PlacesData = PlacesCategories(dictionary: Data)
    if let utilitie = self.PlacesData?.places {
    for item in utilitie {
    self.skip += 1
    self.places.append(item)
    }
    }

    if self.PlacesData?.utilitie.count != 0 {
    self.UtilitieData = self.PlacesData?.utilitie ?? [Utilitie]()
    self.UtilitieData.insert(Utilitie(dictionary: ["id": 0,"title":"All".localizable]), at: 0)
    }
    
    self.IfNoData()
    self.fetchingMore = false
    self.Animations == true ? self.UtilitieCollection.SetAnimations() {self.Animations = false} : self.UtilitieCollection.reloadData()
    }
}

extension PlacesCategoriesVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.GetPlaces(UtilitiesId: self.IdUtilitie, removeAll: false, ShowDots: false)
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
