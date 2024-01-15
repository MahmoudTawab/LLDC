//
//  HomeVC.swift
//  LLDC
//
//  Created by Emojiios on 29/03/2022.
//

import UIKit
import SDWebImage

class HomeVC: ViewController {
    
    static var MainData : Main?
    override func viewDidLoad() {
        super.viewDidLoad()
        GetMain()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }

    fileprivate func SetUpItems() {
    view.addSubview(ProfileView)
    ProfileView.frame = CGRect(x: 0, y: ControlY(40), width: view.frame.width, height: ControlWidth(50))
        
    view.addSubview(HomeCollection)
    HomeCollection.topAnchor.constraint(equalTo: ProfileView.bottomAnchor, constant: ControlY(10)).isActive = true
    HomeCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    HomeCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    HomeCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    AddRefreshControl(Scroll: HomeCollection, color: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)) {
    self.GetMain(Refresh: true)
    }
    }
    
    func AddData(_ array:[String:Any]) {
        HomeVC.MainData = Main(dictionary: array)
        self.HomeCollection.SetAnimations()
        self.IfNoData(Data:true)
        self.ViewDots.endRefreshing {}
    }
    
    func IfNoData(Data:Bool) {
    ViewNoData.isHidden = Data
    ProfileView.isHidden = !Data
    HomeCollection.isHidden = !Data
    HomeCollection.refreshControl?.endRefreshing()
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(GetMain), for: .touchUpInside)
    }


    lazy var ProfileView:ViewProfile = {
        let View = ViewProfile()
        View.isHidden = true
        View.backgroundColor = .clear
        View.SearchButton.isHidden = false
        View.ProfileView.text = "Let’s explore today’s fun!".localizable
        View.SearchButton.addTarget(self, action: #selector(ActionSearch), for: .touchUpInside)
        View.IconQR.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionQR)))
        View.ViewQR.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionQR)))
        View.LabelName.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionProfile)))
        View.ProfileView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionProfile)))
        View.LabelName.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionProfile)))
        View.ProfileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionProfile)))
        return View
    }()
    
    @objc func ActionSearch() {
    Present(ViewController: self, ToViewController: SearchVC())
    }
    
    @objc func ActionProfile() {
    Present(ViewController: self, ToViewController: ProfileVC())
    }
    
    @objc func ActionQR() {
    Present(ViewController: self, ToViewController: ScanQRVC())
    }

    let CategoriesId = "CategoriesId"
    let ِAdvertisement = "ِAdvertisement"
    let JardinsId = "Jardins"
    let ShopsOffers = "ShopsOffers"
    let FoodBeverage = "FoodBeverage"
    let HappeningNowId = "HappeningNow"
    let ComingSoonId = "ComingSoon"
    lazy var HomeCollection: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.isHidden = true
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(AppCategories.self, forCellWithReuseIdentifier: CategoriesId)
        vc.register(AppAdvertisement.self, forCellWithReuseIdentifier: ِAdvertisement)
        vc.register(JardinsAreas.self, forCellWithReuseIdentifier: JardinsId)
        vc.register(AppAdvertisement.self, forCellWithReuseIdentifier: ShopsOffers)
        vc.register(ComingSoon.self, forCellWithReuseIdentifier: FoodBeverage)
        vc.register(HomeHappeningNow.self, forCellWithReuseIdentifier: HappeningNowId)
        vc.register(ComingSoon.self, forCellWithReuseIdentifier: ComingSoonId)
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        return vc
    }()

}

extension HomeVC : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout ,CategoriesDelegate ,JardinsDelegate , AppAdvertisementDelegate ,HomeHappeningNowDelegate ,ComingSoonDelegate {
            
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesId, for: indexPath) as! AppCategories
        cell.isHidden = HomeVC.MainData?.mainScreen?.Categories.count != 0 ? false : true
        cell.Categories = HomeVC.MainData?.mainScreen?.Categories ?? []
        cell.Delegate = self
            
        return cell
        case 1:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ِAdvertisement, for: indexPath) as! AppAdvertisement
        cell.isHidden = HomeVC.MainData?.mainScreen?.featuredEvents.count != 0 ? false : true
        cell.featuredEvents = HomeVC.MainData?.mainScreen?.featuredEvents ?? []
        cell.AdvertisementLabel.text = "Featured Events".localizable
        cell.advertisement = .featuredEvents
        cell.Delegate = self
            
        return cell
        case 2:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JardinsId, for: indexPath) as! JardinsAreas
        cell.isHidden = HomeVC.MainData?.mainScreen?.jardins.count != 0 ? false : true
        cell.JardinsData = HomeVC.MainData?.mainScreen?.jardins ?? []
        cell.JardinsLabel.text = "Jardins".localizable
        cell.Delegate = self
            
        return cell
        case 3:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopsOffers, for: indexPath) as! AppAdvertisement
        cell.isHidden = HomeVC.MainData?.mainScreen?.shopsOffers.count != 0 ? false : true
        cell.shopsOffers = HomeVC.MainData?.mainScreen?.shopsOffers ?? []
        cell.AdvertisementLabel.text = "Shops offers".localizable
        cell.advertisement = .shopsOffers
        cell.Delegate = self
            
        return cell
        case 4:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodBeverage, for: indexPath) as! ComingSoon
        cell.isHidden = HomeVC.MainData?.mainScreen?.foodBeverage.count != 0 ? false : true
        cell.foodBeverage = HomeVC.MainData?.mainScreen?.foodBeverage ?? []
        cell.ComingSoonLabel.text = "Food & Beverage".localizable
        cell.ComingSoonEnum = .foodBeverage
        cell.Delegate = self
            
        return cell
        case 5:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HappeningNowId, for: indexPath) as! HomeHappeningNow
        cell.isHidden = HomeVC.MainData?.mainScreen?.happeningNow.count != 0 ? false : true
        cell.foodBeveraget = HomeVC.MainData?.mainScreen?.foodBeverage ?? []
        cell.HappeningLabel.text = "Happening now".localizable
        cell.Delegate = self
        
        return cell
        case 6:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComingSoonId, for: indexPath) as! ComingSoon
        cell.isHidden = HomeVC.MainData?.mainScreen?.comingSoon.count != 0 ? false : true
        cell.comingSoon = HomeVC.MainData?.mainScreen?.comingSoon ?? []
        cell.ComingSoonLabel.text = "Coming soon Events".localizable
        cell.ImageIcon.isHidden = true
        cell.ComingSoonEnum = .comingSoon
        cell.Delegate = self
            
        return cell
        default:
        return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
        return CGSize(width: collectionView.frame.width - ControlWidth(30), height: HomeVC.MainData?.mainScreen?.Categories.count != 0 ? ControlWidth(110):0)
            
        case 1:
        return CGSize(width: collectionView.frame.width - ControlWidth(30), height: HomeVC.MainData?.mainScreen?.featuredEvents.count != 0 ? ControlWidth(290):0)
            
        case 2:
        return CGSize(width: collectionView.frame.width - ControlWidth(30), height: HomeVC.MainData?.mainScreen?.jardins.count != 0 ? ControlWidth(175):0)
            
        case 3:
        return CGSize(width: collectionView.frame.width - ControlWidth(30), height: HomeVC.MainData?.mainScreen?.shopsOffers.count != 0 ? ControlWidth(290):0)
          
        case 4:
        return CGSize(width: collectionView.frame.width - ControlWidth(30), height: HomeVC.MainData?.mainScreen?.foodBeverage.count != 0 ? ControlWidth(225):0)
            
        case 5:
        return CGSize(width: collectionView.frame.width - ControlWidth(30), height: HomeVC.MainData?.mainScreen?.happeningNow.count != 0 ? ControlWidth(290):0)
            
        case 6:
        return CGSize(width: collectionView.frame.width - ControlWidth(30), height: HomeVC.MainData?.mainScreen?.comingSoon.count != 0 ? ControlWidth(225):0)
            
        default:
        return .zero
        }
        
    }
    
//    Categories Delegate
    func CategoriesSelect(_ indexPath: IndexPath) {
        if let Id = HomeVC.MainData?.mainScreen?.Categories[indexPath.item].id {
        let Places = PlacesCategoriesVC()
        Places.Id = Id
        Places.Dismiss.TextLabel = HomeVC.MainData?.mainScreen?.Categories[indexPath.item].title ?? ""
        Present(ViewController: self, ToViewController: Places)
        }
    }
    
//    Jardins Areas Delegate
    func JardinsSelect(_ indexPath: IndexPath) {
    let AreaDetails = AreaDetailsVC()
    AreaDetails.id = HomeVC.MainData?.mainScreen?.jardins[indexPath.item].id
    AreaDetails.Utilities = HomeVC.MainData?.mainScreen?.jardins[indexPath.item].title ?? ""
    Present(ViewController: self, ToViewController: AreaDetails)
    }
    
//  featured Events Delegate
    func featuredEvents(Index:IndexPath,id: Int) {
        if let PlaceId = HomeVC.MainData?.mainScreen?.featuredEvents[Index.item].id {
        GoToDetails(PlaceId:PlaceId,screenId: id)
        }
    }
    
//  featured shops Offers
    func shopsOffers(Index:IndexPath,id: Int) {
    if let PlaceId = HomeVC.MainData?.mainScreen?.shopsOffers[Index.item].id {
    GoToDetails(PlaceId:PlaceId,screenId: id)
    }
    }
    
//  featured Happening Now
    func HappeningNow(Index:IndexPath,id: Int) {
    if let PlaceId = HomeVC.MainData?.mainScreen?.happeningNow[Index.item].id {
    GoToDetails(PlaceId:PlaceId,screenId: id)
    }
    }
    
    //  featured food Beverage
    func foodBeverage(Index:IndexPath,id: Int) {
    if let PlaceId = HomeVC.MainData?.mainScreen?.foodBeverage[Index.item].id {
    GoToDetails(PlaceId:PlaceId,screenId: id)
    }
    }
        
    //  featured coming Soon
    func comingSoon(Index:IndexPath,id: Int) {
    if let PlaceId = HomeVC.MainData?.mainScreen?.comingSoon[Index.item].id {
    GoToDetails(PlaceId:PlaceId,screenId: id)
    }
    }
    
    func GoToDetails(PlaceId:String,screenId: Int) {
        switch screenId {
        case 1:
        let Restaurant = RestaurantVC()
        Restaurant.AreaId = PlaceId
        Present(ViewController: self, ToViewController: Restaurant)
        case 2:
        let Retail = RetailVC()
        Retail.AreaId = PlaceId
        Present(ViewController: self, ToViewController: Retail)
        case 3:
        let Events = EventsVC()
        Events.AreaId = PlaceId
        Present(ViewController: self, ToViewController: Events)
        case 4:
        let Library = LibraryVC()
        Library.AreaId = PlaceId
        Present(ViewController: self, ToViewController: Library)
        case 5:
        let Museum = MuseumVC()
        Museum.AreaId = PlaceId
        Present(ViewController: self, ToViewController: Museum)
        case 6:
        let Corporate = CorporateVC()
        Corporate.AreaId = PlaceId
        Present(ViewController: self, ToViewController: Corporate)
        default:
        break
        }
    }
    
    @objc func GetMain(Refresh:Bool = false) {
//    if HomeVC.MainData == nil || Refresh {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let api = "\(url + GetMainScreen)"
//        
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                   "Platform": "I",
//                                   "DeviceID": udid,
//                                   "Lang": "lang".localizable]
        
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = ["mainScreen":
        [
            "topCollectionView": [
                ["id" : 1 ,"title" : "Categorie 1","iconPath" : "https://cdn2.steamgriddb.com/icon_thumb/8ddc98fe6483c3ecddcb687eb2d30d37.png"],
                ["id" : 2 ,"title" : "Categorie 2","iconPath" : "https://cdn2.steamgriddb.com/icon_thumb/8ddc98fe6483c3ecddcb687eb2d30d37.png"],
                ["id" : 3 ,"title" : "Categorie 3","iconPath" : "https://cdn2.steamgriddb.com/icon_thumb/8ddc98fe6483c3ecddcb687eb2d30d37.png"],
                ["id" : 4 ,"title" : "Categorie 4","iconPath" : "https://cdn2.steamgriddb.com/icon_thumb/8ddc98fe6483c3ecddcb687eb2d30d37.png"],
                ["id" : 5 ,"title" : "Categorie 5","iconPath" : "https://cdn2.steamgriddb.com/icon_thumb/8ddc98fe6483c3ecddcb687eb2d30d37.png"]],
            
            "featuredEvents": [
                ["id" : "","title" : "Title","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7vWb7p-dN0y8P1ebH2gVosl64r-CGWc3FBg&usqp=CAU","screenId" : 1,"screenName" : "String"],
                ["id" : "","title" : "Title","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7vWb7p-dN0y8P1ebH2gVosl64r-CGWc3FBg&usqp=CAU","screenId" : 1,"screenName" : "String"],
                ["id" : "","title" : "Title","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7vWb7p-dN0y8P1ebH2gVosl64r-CGWc3FBg&usqp=CAU","screenId" : 6,"screenName" : "String"],
                ["id" : "","title" : "Title","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7vWb7p-dN0y8P1ebH2gVosl64r-CGWc3FBg&usqp=CAU","screenId" : 6,"screenName" : "String"],
                ["id" : "","title" : "Title","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7vWb7p-dN0y8P1ebH2gVosl64r-CGWc3FBg&usqp=CAU","screenId" : 6,"screenName" : "String"],
                ["id" : "","title" : "Title","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7vWb7p-dN0y8P1ebH2gVosl64r-CGWc3FBg&usqp=CAU","screenId" : 6,"screenName" : "String"]],
            
            "jardins" : [
                ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","background" : "#EC7063"],
                ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","background" : "#AF7AC5"],
                ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","background" : "#5499C7"],
                ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","background" : "#48C9B0"],
                ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","background" : "#52BE80"],
                ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","background" : "#58D68D"],
                ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","background" : "#F4D03F"]],
            
            "shopsOffers" : [
                ["id" : "","title" : "Title", "photoPath" : "https://cdn2.vectorstock.com/i/1000x1000/39/41/shopping-special-offers-vector-20543941.jpg","description" : "String","screenId" : 2,"screenName" : "String"],
                ["id" : "","title" : "Title", "photoPath" : "https://cdn2.vectorstock.com/i/1000x1000/39/41/shopping-special-offers-vector-20543941.jpg","description" : "String","screenId" : 2,"screenName" : "String"],
                ["id" : "","title" : "Title", "photoPath" : "https://cdn2.vectorstock.com/i/1000x1000/39/41/shopping-special-offers-vector-20543941.jpg","description" : "String","screenId" : 2,"screenName" : "String"],
                ["id" : "","title" : "Title", "photoPath" : "https://cdn2.vectorstock.com/i/1000x1000/39/41/shopping-special-offers-vector-20543941.jpg","description" : "String","screenId" : 2,"screenName" : "String"],
                ["id" : "","title" : "Title", "photoPath" : "https://cdn2.vectorstock.com/i/1000x1000/39/41/shopping-special-offers-vector-20543941.jpg","description" : "String","screenId" : 2,"screenName" : "String"],
                ["id" : "","title" : "Title", "photoPath" : "https://cdn2.vectorstock.com/i/1000x1000/39/41/shopping-special-offers-vector-20543941.jpg","description" : "String","screenId" : 2,"screenName" : "String"],
                ["id" : "","title" : "Title", "photoPath" : "https://cdn2.vectorstock.com/i/1000x1000/39/41/shopping-special-offers-vector-20543941.jpg","description" : "String","screenId" : 2,"screenName" : "String"]],
            
            "foodBeverage" : [
                ["id" :"","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRezkhZEGyU-SbkR5X1RGxo8OxQFLfKonocyg&usqp=CAU","openingHoursFrom" : "10:10 pm","openingHoursTo" : "12:30 am","screenId" : 3,"screenName" : "String"],
                ["id" :"","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRezkhZEGyU-SbkR5X1RGxo8OxQFLfKonocyg&usqp=CAU","openingHoursFrom" : "10:10 pm","openingHoursTo" : "12:30 am","screenId" : 3,"screenName" : "String"],
                ["id" :"","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRezkhZEGyU-SbkR5X1RGxo8OxQFLfKonocyg&usqp=CAU","openingHoursFrom" : "10:10 pm","openingHoursTo" : "12:30 am","screenId" : 3,"screenName" : "String"],
                ["id" :"","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRezkhZEGyU-SbkR5X1RGxo8OxQFLfKonocyg&usqp=CAU","openingHoursFrom" : "10:10 pm","openingHoursTo" : "12:30 am","screenId" : 3,"screenName" : "String"],
                ["id" :"","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRezkhZEGyU-SbkR5X1RGxo8OxQFLfKonocyg&usqp=CAU","openingHoursFrom" : "10:10 pm","openingHoursTo" : "12:30 am","screenId" : 3,"screenName" : "String"],
                ["id" :"","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRezkhZEGyU-SbkR5X1RGxo8OxQFLfKonocyg&usqp=CAU","openingHoursFrom" : "10:10 pm","openingHoursTo" : "12:30 am","screenId" : 3,"screenName" : "String"],
                ["id" :"","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRezkhZEGyU-SbkR5X1RGxo8OxQFLfKonocyg&usqp=CAU","openingHoursFrom" : "10:10 pm","openingHoursTo" : "12:30 am","screenId" : 3,"screenName" : "String"]],
            
            "happeningNow" : [
                ["id" : "","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9YYh5Fk1u9VsWWr1MhkyQeOzeNbtnnMO96g&usqp=CAU","screenId" : 4,"screenName" : ""],
                ["id" : "","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9YYh5Fk1u9VsWWr1MhkyQeOzeNbtnnMO96g&usqp=CAU","screenId" : 4,"screenName" : ""],
                ["id" : "","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9YYh5Fk1u9VsWWr1MhkyQeOzeNbtnnMO96g&usqp=CAU","screenId" : 4,"screenName" : ""],
                ["id" : "","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9YYh5Fk1u9VsWWr1MhkyQeOzeNbtnnMO96g&usqp=CAU","screenId" : 4,"screenName" : ""],
                ["id" : "","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9YYh5Fk1u9VsWWr1MhkyQeOzeNbtnnMO96g&usqp=CAU","screenId" : 4,"screenName" : ""],
                ["id" : "","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9YYh5Fk1u9VsWWr1MhkyQeOzeNbtnnMO96g&usqp=CAU","screenId" : 4,"screenName" : ""],
                ["id" : "","title" : "Title","location" : "Cairo","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9YYh5Fk1u9VsWWr1MhkyQeOzeNbtnnMO96g&usqp=CAU","screenId" : 4,"screenName" : ""]],
            
            "comingSoon" : [
                ["id" : "","title" : "Title","location" : "Cairo","startDate" : "23/10","startTime" : "12:30 am","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQyD446vRksw83BsovYbnyQGgYdWro8cLX8Q&usqp=CAU","screenId" : 5,"screenName" : "String"],
                ["id" : "","title" : "Title","location" : "Cairo","startDate" : "23/10","startTime" : "12:30 am","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQyD446vRksw83BsovYbnyQGgYdWro8cLX8Q&usqp=CAU","screenId" : 5,"screenName" : "String"],
                ["id" : "","title" : "Title","location" : "Cairo","startDate" : "23/10","startTime" : "12:30 am","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQyD446vRksw83BsovYbnyQGgYdWro8cLX8Q&usqp=CAU","screenId" : 5,"screenName" : "String"],
                ["id" : "","title" : "Title","location" : "Cairo","startDate" : "23/10","startTime" : "12:30 am","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQyD446vRksw83BsovYbnyQGgYdWro8cLX8Q&usqp=CAU","screenId" : 5,"screenName" : "String"],
                ["id" : "","title" : "Title","location" : "Cairo","startDate" : "23/10","startTime" : "12:30 am","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQyD446vRksw83BsovYbnyQGgYdWro8cLX8Q&usqp=CAU","screenId" : 5,"screenName" : "String"],
                ["id" : "","title" : "Title","location" : "Cairo","startDate" : "23/10","startTime" : "12:30 am","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQyD446vRksw83BsovYbnyQGgYdWro8cLX8Q&usqp=CAU","screenId" : 5,"screenName" : "String"],
                ["id" : "","title" : "Title","location" : "Cairo","startDate" : "23/10","startTime" : "12:30 am","photoPath" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQyD446vRksw83BsovYbnyQGgYdWro8cLX8Q&usqp=CAU","screenId" : 5,"screenName" : "String"]]
        ],
        "profile":
        [
        "uid": "","sqlId": "","fullName": "Mahmoud Tawab","email": "Mahmoud@mail.com","phone": "01204474410","emailVerified": true,"phoneVerified": true,"male": true,"birthday": "String","cityId": 1,"city": "Cairo","homeAddress": "","linkedIn": "","facebook": "","instagram": "","familyMembers": "4","qrPath": "","receiveNotifications": false,"receiveEmail": true,"company": "","workLocation": "","memberTypeId": 1,"memberType": "","profileImg": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAlpQBahpDZSNYA6W-nCeQlpF_RcoYkAbdSg&usqp=CAU","iconPath": "2","isplatinium": true,
            
        "Family" : [
                "id": "","email": "tawab@mail.com","fullName": "tawab hosny","profileImg": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK0EztGrrGWCA9CYjGkTmcQEmmqdDQaxLvQg&usqp=CAU","phone": "01204474410","birthday": ""
                ,"activated" : true
                ,"relationId": 1
                ,"relation": ""
                ,"createdIn": ""
            ]
        ]] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.HomeCollection.refreshControl?.endRefreshing()
            if Refresh {
                self.HomeCollection.RemoveAnimations {
                    HomeVC.MainData = nil
                    self.HomeCollection.reloadData()
                    self.AddData(data)
                }
            }else{
                self.AddData(data)
            }
        }
    
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.IfNoData(Data:false)
//    self.SetUpIsError(error, true) {
//    self.GetMain(Refresh:Refresh)}
//    }
//    }else{
//    self.IfNoData(Data:true)
//    self.HomeCollection.SetAnimations()
//    }
    }
    

}
