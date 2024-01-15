//
//  PlacesUtilitiesVC.swift
//  LLDC
//
//  Created by Emojiios on 08/06/2022.
//

import UIKit
import SDWebImage

class PlacesUtilitiesVC: ViewController  {
        
    var skip = 0
    var areaId : Int?
    var utilitiesId : Int?
    var IdUtilitie : Int = 0

    var Animations = true
    var fetchingMore = false
    var places = [Places]()
    var Info : UtilitiesInfo?
    var UtilitieData = [Utilitie]()
    var UtilitiesPlaces : PlacesUtilities?
    
    var headerHeightConstraint: NSLayoutConstraint!
    let maxHeaderHeight: CGFloat = ControlHeight(320)
    let minHeaderHeight: CGFloat = ControlHeight(120)
    var previousScrollOffset: CGFloat = 0
    var previousScrollViewHeight: CGFloat = 0
    override func viewDidLoad() {
    super.viewDidLoad()
    SetUp()
    SetDataPlacesUtilities()
    view.backgroundColor = #colorLiteral(red: 0.9414902329, green: 0.9350261092, blue: 0.9038181305, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    headerHeightConstraint.constant = maxHeaderHeight
    updateHeader()
    }
    
    fileprivate func SetUp() {
    previousScrollViewHeight = PlacesUtilitiesCollection.contentSize.height
        
    view.addSubview(ViewTop)
    headerHeightConstraint = ViewTop.heightAnchor.constraint(equalToConstant: ControlHeight(320))
    headerHeightConstraint?.isActive = true
    ViewTop.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    ViewTop.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    ViewTop.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    ViewTop.addSubview(UtilitiesImage)
    UtilitiesImage.topAnchor.constraint(equalTo: ViewTop.topAnchor).isActive = true
    UtilitiesImage.leadingAnchor.constraint(equalTo: ViewTop.leadingAnchor).isActive = true
    UtilitiesImage.trailingAnchor.constraint(equalTo: ViewTop.trailingAnchor).isActive = true
    UtilitiesImage.bottomAnchor.constraint(equalTo: ViewTop.bottomAnchor , constant: ControlHeight(-100)).isActive = true
        
    ViewTop.addSubview(UtilitiesName)
    UtilitiesName.topAnchor.constraint(equalTo: UtilitiesImage.bottomAnchor,constant: ControlX(25)).isActive = true
    UtilitiesName.leadingAnchor.constraint(equalTo: ViewTop.leadingAnchor,constant: ControlX(15)).isActive = true
    UtilitiesName.trailingAnchor.constraint(equalTo: ViewTop.trailingAnchor,constant: ControlX(-15)).isActive = true
    UtilitiesName.heightAnchor.constraint(equalToConstant: ControlHeight(30)).isActive = true
        
    ViewTop.addSubview(StackPopUp)
    StackPopUp.topAnchor.constraint(equalTo: UtilitiesName.bottomAnchor,constant: ControlX(10)).isActive = true
    StackPopUp.leadingAnchor.constraint(equalTo: ViewTop.leadingAnchor,constant: ControlX(15)).isActive = true
    StackPopUp.trailingAnchor.constraint(equalTo: ViewTop.trailingAnchor,constant: ControlX(-15)).isActive = true
    StackPopUp.heightAnchor.constraint(equalToConstant: ControlHeight(30)).isActive = true
        
    view.addSubview(PlacesUtilitiesCollection)
    PlacesUtilitiesCollection.topAnchor.constraint(equalTo: ViewTop.bottomAnchor,constant: ControlX(10)).isActive = true
    PlacesUtilitiesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
    PlacesUtilitiesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-15)).isActive = true
    PlacesUtilitiesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
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
        self.PlacesUtilitiesCollection.contentOffset = CGPoint(x: self.PlacesUtilitiesCollection.contentOffset.x, y: position)
    }
    
    func updateHeader() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let openAmount = self.headerHeightConstraint.constant - self.minHeaderHeight
        let percentage = openAmount / range
        
        Dismiss.Label.alpha = abs(percentage - 1)
        self.UtilitiesName.alpha = percentage
        self.UtilitiesImage.alpha = percentage
    }
    
    ///
    lazy var ViewTop: UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.isHidden = true
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var UtilitiesImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.image = UIImage(named: "Group 26056")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var UtilitiesName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var SubUtilitiesTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tf.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)
        tf.ShowError = false
        tf.text = "All".localizable
        tf.IconImage = UIImage(named: "Path")
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        tf.addTarget(self, action: #selector(ActionUtilitie), for: .editingDidBegin)
        tf.Icon.addTarget(self, action: #selector(ActionUtilitie), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionUtilitie)))
        return tf
    }()
    
    lazy var SubUtilitiesLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "SubUtilities".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
        Label.widthAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        return Label
    }()
    
    lazy var StackPopUp : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [SubUtilitiesLabel,SubUtilitiesTF])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(10)
        Stack.distribution = .fillProportionally
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    let PopUp = PopUpDownView()
   @objc func ActionUtilitie() {
        if UtilitieData.count != 0 {
        let height = CGFloat(UtilitieData.count) * ControlWidth(50)
        let Height = height < view.frame.height - ControlX(150) ? height:view.frame.height - ControlX(150)
        let NewHeight = Height < ControlX(160) ? ControlX(160):Height
                
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
        UtilitieTable.frame = CGRect(x: 0, y: ControlX(40), width: PopUp.view.frame.width, height: PopUp.view.frame.height - ControlX(200))
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
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()

    var PlacesUtilitiesId = "PlacesUtilitiesId"
    lazy var PlacesUtilitiesCollection: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(10), right: 0)
        vc.register(UtilitieCell.self, forCellWithReuseIdentifier: PlacesUtilitiesId)
        return vc
    }()
    
    func IfNoData() {
    self.ViewTop.isHidden = UtilitiesPlaces != nil ? false : true
    self.ViewNoData.isHidden = UtilitiesPlaces != nil ? true : false
    self.PlacesUtilitiesCollection.isHidden = UtilitiesPlaces != nil ? false : true
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(SetDataPlacesUtilities), for: .touchUpInside)
    }
}

extension PlacesUtilitiesVC : UITableViewDelegate , UITableViewDataSource {

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
    SubUtilitiesTF.text = UtilitieData[indexPath.row].title
    SetDataPlacesUtilities(SebUtilitiesId: UtilitieData[indexPath.row].id ?? 0, removeAll: true)
    SelectUtilitie = indexPath
    tableView.reloadData()
    }
    }
}


extension PlacesUtilitiesVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UtilitieDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlacesUtilitiesId, for: indexPath) as! UtilitieCell
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ControlX(15)
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
    if let index = PlacesUtilitiesCollection.indexPath(for: Cell) {
    let Reviews = ReviewsVC()
    Reviews.PlacesId = places[index.item].id
    Present(ViewController: self, ToViewController: Reviews)
    }
    }
    
    
    @objc func SetDataPlacesUtilities(SebUtilitiesId:Int = 0 ,removeAll:Bool = false, ShowDots:Bool = true) {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    guard let UtilitiesId = utilitiesId else{return}
//    guard let AreaId = areaId else{return}
//
//    let api = "\(url + GetPlacesUtilities)"
//    let token = defaults.string(forKey: "jwt") ?? ""
//
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                   "Platform": "I",
//                                   "Lang": "lang".localizable,
//                                   "areaId": AreaId,
//                                   "utilitiesId": UtilitiesId,
//                                   "sebUtilitiesId": SebUtilitiesId,
//                                   "Skip":skip,
//                                   "Take": 20]
        
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = ["utilitiesInfo":["id" : 1,"title" : "Test String","coverPhotoPath" : "https://retaildesignblog.net/wp-content/uploads/2014/01/diptyque-ville-rose-boutique-by-centdegres-diptyque-Toulouse-France.jpg"],
        
                "places": [
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
                 
                 ["id" :"","coverPhotoPath" : "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg","placeName" : "placeName","rate" : 2.5,"areaIcon" : "String","areaId" : 1
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
                                  
                    ,"subUtilities":
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
                self.PlacesUtilitiesCollection.RemoveAnimations {
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
//    self.IfNoData()
//    self.SetUpIsError(error, true) {self.SetDataPlacesUtilities()}
//    }
    }
    
    func AddData(Data:[String:Any]) {
    self.UtilitiesPlaces = PlacesUtilities(dictionary: Data)
        
    if let utilitie = self.UtilitiesPlaces?.places {
    for item in utilitie {
    self.skip += 1
    self.places.append(item)
    }
    }

    if self.UtilitiesPlaces?.subUtilities.count != 0 {
    self.UtilitieData = self.UtilitiesPlaces?.subUtilities ?? [Utilitie]()
    self.UtilitieData.insert(Utilitie(dictionary: ["id": 0,"title":"All".localizable]), at: 0)
    }
        
    if self.UtilitiesPlaces?.utilitiesInfo != nil {
    self.Info = self.UtilitiesPlaces?.utilitiesInfo
    UtilitiesName.text = self.Info?.title
    Dismiss.TextLabel = self.Info?.title ?? ""
    UtilitiesImage.sd_setImage(with: URL(string: self.Info?.coverPhotoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
    }
    
    self.IfNoData()
    self.fetchingMore = false
    self.Animations == true ? self.PlacesUtilitiesCollection.SetAnimations() {self.Animations = false} : self.PlacesUtilitiesCollection.reloadData()
    }
    
    @objc func refresh() {
    skip = 0
    SetDataPlacesUtilities(removeAll: true)
    }
}

extension PlacesUtilitiesVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.SetDataPlacesUtilities(SebUtilitiesId: self.IdUtilitie, removeAll: false, ShowDots: false)
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

