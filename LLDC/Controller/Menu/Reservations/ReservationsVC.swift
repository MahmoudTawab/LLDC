//
//  ReservationsVC.swift
//  LLDC
//
//  Created by Emojiios on 03/04/2022.
//

import UIKit
import SDWebImage

class ReservationsVC : ViewController {
    
    var skip = 0
    var Animations = true
    var fetchingMore = false
    var Categories = [TopCollection]()
    var EventCategories = [Reservations]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        GetDataCategories()
    }
    
    fileprivate func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Dismiss.TextLabel = "Reservations".localizable
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
        view.addSubview(ReservationsCategories)
        ReservationsCategories.frame = CGRect(x: ControlX(15), y: Dismiss.frame.maxY + ControlY(15) , width: view.frame.width - ControlX(30), height: ControlWidth(110))
        
        view.addSubview(EventTable)
        EventTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        EventTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        EventTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        EventTable.topAnchor.constraint(equalTo: ReservationsCategories.bottomAnchor, constant: ControlX(15)).isActive = true
        
        view.addSubview(ViewNoDataTable)
        ViewNoDataTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(20)).isActive = true
        ViewNoDataTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-20)).isActive = true
        ViewNoDataTable.topAnchor.constraint(equalTo: ReservationsCategories.bottomAnchor, constant: ControlX(10)).isActive = true
        ViewNoDataTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: ControlX(-50)).isActive = true

    }

    let CategoriesId = "Categories"
    var CategoriesSelect = IndexPath(item: 0, section: 0)
    lazy var ReservationsCategories: CollectionAnimations = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.isHidden = true
        vc.showsHorizontalScrollIndicator = false
        vc.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesId)
        vc.contentInset = UIEdgeInsets(top: 0, left: ControlY(2), bottom: 0, right: 0)
        return vc
    }()
    
    var EventId = "EventId"
    lazy var EventTable : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.separatorColor = .clear
        tv.rowHeight = ControlWidth(150)
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        tv.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tv.addPullLoadableView(loadMoreView, type: .loadMore)
        
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(EventCell.self, forCellReuseIdentifier: EventId)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        return tv
    }()

    lazy var ViewNoDataTable : ViewIsError = {
        let View = ViewIsError()
        View.backgroundColor = .clear
        View.isHidden = true
        View.ImageIcon = "ErrorService"
        View.TextRefresh = "Try Again".localizable
        View.MessageTitle = "Something went wrong".localizable
        View.translatesAutoresizingMaskIntoConstraints =  false
        View.RefreshButton.addTarget(self, action: #selector(ActionNoDataTable), for: .touchUpInside)
        View.MessageDetails = "Something went wrong while processing your request, please try again later".localizable
        return View
    }()

    var CategorieId : String?
    @objc func ActionNoDataTable() {
    if let id = CategorieId {
    GetDataReservations(categoryId: ("\(id)"), removeAll: true, ShowDots: true)
    }
    }
}

extension ReservationsVC : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {


  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Categories.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesId, for: indexPath) as! CategoriesCell
    cell.layer.shadowRadius = 4
    cell.layer.shadowOpacity = 0.4
    cell.layer.shadowOffset = .zero
    cell.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
    cell.layer.cornerRadius = ControlX(8)
    cell.backgroundColor = CategoriesSelect == indexPath ? #colorLiteral(red: 0.8994513154, green: 0.9072406292, blue: 0.8371486068, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    cell.CategoriesLabel.text = Categories[indexPath.item].title
    cell.ImageView.sd_setImage(with: URL(string: Categories[indexPath.item].iconPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height - ControlY(5))
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return ControlX(15)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if Categories[CategoriesSelect.item].id != Categories[indexPath.item].id {
    if let id = Categories[indexPath.item].id {
    skip = 0
    self.CategorieId = ("\(id)")
    GetDataReservations(categoryId: ("\(id)"), removeAll: true, ShowDots: true)
    }
    }
    CategoriesSelect = indexPath
    ReservationsCategories.reloadData()
  }
    
    @objc func GetDataCategories() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//        
//    let api = "\(url + GetCategories)"
//    let sqlId = getProfileObject().sqlId ?? ""
//    let token = defaults.string(forKey: "jwt") ?? ""
//
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                    "Platform": "I",
//                                    "SqlId": sqlId,
//                                    "Lang": "lang".localizable]
            
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
      let data = [
            ["id" : 1 ,"title" : "Categories 1","iconPath" : "https://cdn2.steamgriddb.com/icon_thumb/8ddc98fe6483c3ecddcb687eb2d30d37.png"],
            ["id" : 2 ,"title" : "Categories 2","iconPath" : "https://cdn2.steamgriddb.com/icon_thumb/8ddc98fe6483c3ecddcb687eb2d30d37.png"],
            ["id" : 3 ,"title" : "Categories 3","iconPath" : "https://cdn2.steamgriddb.com/icon_thumb/8ddc98fe6483c3ecddcb687eb2d30d37.png"],
            ["id" : 4 ,"title" : "Categories 4","iconPath" : "https://cdn2.steamgriddb.com/icon_thumb/8ddc98fe6483c3ecddcb687eb2d30d37.png"],
            ["id" : 5 ,"title" : "Categories 5","iconPath" : "https://cdn2.steamgriddb.com/icon_thumb/8ddc98fe6483c3ecddcb687eb2d30d37.png"]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            for item in data {
                self.Categories.append(TopCollection(dictionary: item))
                if self.Categories.count == data.count {
                    if let id = self.Categories.first?.id {
                        self.CategorieId = ("\(id)")
                        self.GetDataReservations(categoryId: ("\(id)"), removeAll: true, ShowDots: false)
                    }
                }
            }
            self.IfNoData()
        }
        
//    } Err: { error in
//    self.IfNoData()
//    self.ViewDots.endRefreshing(error, .error) {}
//    }
    }
    
    func IfNoData() {
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(GetDataCategories), for: .touchUpInside)
    self.ReservationsCategories.isHidden = self.Categories.count == 0 ? true : false
    self.ViewNoData.isHidden = self.Categories.count != 0 ? true : false
    self.ReservationsCategories.SetAnimations()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    self.ViewDots.endRefreshing(){}
    }
    }
}

extension ReservationsVC : UITableViewDelegate ,UITableViewDataSource , EventDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventId, for: indexPath) as! EventCell
        cell.selectionStyle = .none
        cell.Delegate = self
        cell.TimeLabel.TextLabel = EventCategories[indexPath.row].time ?? ""
        cell.DateLabel.TextLabel = EventCategories[indexPath.row].date ?? ""
        cell.TitleLabel.TextLabel = EventCategories[indexPath.row].placeTitle ?? ""
        cell.LocationLabel.TextLabel = EventCategories[indexPath.row].areasTitel ?? ""
        
        cell.ImageView.sd_setImage(with: URL(string: EventCategories[indexPath.row].coverPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let BookConfirmation = BookConfirmationVC()
    BookConfirmation.Reservations = self
    BookConfirmation.reservationId = EventCategories[indexPath.row].id
    BookConfirmation.BookButtonTitle = "Cancel reservation".localizable
    Present(ViewController: self, ToViewController: BookConfirmation)
    }
    
    func ActionShowEvent(_ Cell: EventCell) {
    if let index = EventTable.indexPath(for: Cell) {
    let BookConfirmation = BookConfirmationVC()
    BookConfirmation.Reservations = self
    BookConfirmation.reservationId = EventCategories[index.row].id
    BookConfirmation.BookButtonTitle = "Cancel reservation".localizable
    Present(ViewController: self, ToViewController: BookConfirmation)
    }
    }

    @objc func GetDataReservations(categoryId:String = "", removeAll:Bool = false, ShowDots:Bool = true) {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//
//    let api = "\(url + GetReservations)"
//    let sqlId = getProfileObject().sqlId ?? ""
//    let token = defaults.string(forKey: "jwt") ?? ""
//
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                    "Platform": "I",
//                                    "SqlId": sqlId,
//                                    "Lang": "lang".localizable,
//                                    "categoryId": categoryId,
//                                    "take": 10,
//                                    "skip": skip]
       
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in

        let data = [["id" : "","placesId" : "","placeTitle" : "place Title","coverPath" : "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg","categoryTitle" : "Test String","areasTitel" : "Test Areas Titel","date" : "23/10/1997","time" : "01:30-09:30","canCancel" : true],
            ["id" : "","placesId" : "","placeTitle" : "place Title","coverPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6N_xhIKNoKNkmzh_q4FQ703xnRO9IKrR1fgIxjkdIQ5wSb3tai7eO10JyypfpJ_g41gw&usqp=CAU","categoryTitle" : "Test String","areasTitel" : "Test Areas Titel","date" : "23/10/1997","time" : "01:30-09:30","canCancel" : true],
            ["id" : "","placesId" : "","placeTitle" : "place Title","coverPath" : "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg","categoryTitle" : "Test String","areasTitel" : "Test Areas Titel","date" : "23/10/1997","time" : "01:30-09:30","canCancel" : false],
            ["id" : "","placesId" : "","placeTitle" : "place Title","coverPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6N_xhIKNoKNkmzh_q4FQ703xnRO9IKrR1fgIxjkdIQ5wSb3tai7eO10JyypfpJ_g41gw&usqp=CAU","categoryTitle" : "Test String","areasTitel" : "Test Areas Titel","date" : "23/10/1997","time" : "01:30-09:30","canCancel" : true],
            ["id" : "","placesId" : "","placeTitle" : "place Title","coverPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6N_xhIKNoKNkmzh_q4FQ703xnRO9IKrR1fgIxjkdIQ5wSb3tai7eO10JyypfpJ_g41gw&usqp=CAU","categoryTitle" : "Test String","areasTitel" : "Test Areas Titel","date" : "23/10/1997","time" : "01:30-09:30","canCancel" : false],
            ["id" : "","placesId" : "","placeTitle" : "place Title","coverPath" : "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg","categoryTitle" : "Test String","areasTitel" : "Test Areas Titel","date" : "23/10/1997","time" : "01:30-09:30","canCancel" : true],
            ["id" : "","placesId" : "","placeTitle" : "place Title","coverPath" : "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg","categoryTitle" : "Test String","areasTitel" : "Test Areas Titel","date" : "23/10/1997","time" : "01:30-09:30","canCancel" : false]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            if removeAll {
                self.EventTable.RemoveAnimations {
                    self.EventCategories.removeAll()
                    self.Animations = true
                    self.AddData(dictionary:data)
                }
            }else{
                self.AddData(dictionary:data)
            }
        }
        
//    } Err: { error in
//    if self.EventCategories.count != 0 {
//    return
//    }else{
//    self.EventTable.RemoveAnimations {
//    self.EventCategories.removeAll()
//    self.IfNoDataReservations()
//    self.ViewDots.endRefreshing(error, .error) {}
//    }
//    }
//    }
    }
    
    func AddData(dictionary:[[String:Any]]) {
    for item in dictionary {
    self.EventCategories.append(Reservations(dictionary: item))
    self.skip += 1
    self.fetchingMore = false
    self.Animations == true ? self.EventTable.SetAnimations() {self.Animations = false} : self.EventTable.reloadData()
    }
    self.IfNoDataReservations()
    }
    
    func IfNoDataReservations() {
    self.EventTable.isHidden = self.EventCategories.count == 0 ? true : false
    self.ViewNoDataTable.isHidden = self.EventCategories.count != 0 ? true : false
    self.ViewDots.endRefreshing(){}
    }
    
    @objc func refresh() {
    skip = 0
    if let id = self.CategorieId {
    self.GetDataReservations(categoryId: ("\(id)"), removeAll: true, ShowDots: true)
    }
    }

}

extension ReservationsVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        if let id = self.CategorieId {
        self.GetDataReservations(categoryId: ("\(id)"), removeAll: false, ShowDots: false)
        }
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
