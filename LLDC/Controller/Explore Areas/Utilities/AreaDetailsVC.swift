//
//  AreaDetailsVC.swift
//  LLDC
//
//  Created by Emojiios on 25/04/2022.
//

import UIKit
import SDWebImage

class AreaDetailsVC: ViewController ,UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, AreaDetailsTopDelegate {
        
    var id : Int?
    var Utilities = String()
    override func viewDidLoad() {
    super.viewDidLoad()
    SetUp()
    GetDetails()
    view.backgroundColor = #colorLiteral(red: 0.9414902329, green: 0.9350261092, blue: 0.9038181305, alpha: 1)
    }
    
    fileprivate func SetUp() {

    view.addSubview(CollectionDetails)
    let TopHeight = UIApplication.shared.statusBarFrame.height
    CollectionDetails.frame = CGRect(x: ControlX(15), y: -TopHeight, width: view.frame.width - ControlX(30), height: view.frame.height + TopHeight)
        
    view.addSubview(Dismiss)
    Dismiss.IconImage.tintColor = .white
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(45), width: view.frame.width - ControlX(20), height: ControlWidth(40))
    }

    var DetailsId = "DetailsId"
    var HeaderId = "HeaderId"
    var TopId = "TopCellId"
    var TitleId = "TitleId"
    lazy var CollectionDetails: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.isHidden = true
        vc.clipsToBounds = false
        vc.showsVerticalScrollIndicator = false
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(10), right: 0)
        vc.register(AreaDetailsCell.self, forCellWithReuseIdentifier: DetailsId)
        vc.register(AreaDetailsTop.self, forCellWithReuseIdentifier: TopId)
        vc.register(UICollectionViewCell.self, forCellWithReuseIdentifier: TitleId)
        vc.register(HeaderView.self, forCellWithReuseIdentifier: HeaderId)
        return vc
    }()
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0,1,2:
        return  1
        case 3:
        return DetailsArea?.utilitie.count ?? 0
        default:
        return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            
        case 0:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderId, for: indexPath) as! HeaderView
        cell.Title.text = DetailsArea?.title ?? ""
        cell.Details.text = DetailsArea?.about ?? ""
        cell.LocationLabel.TextLabel = DetailsArea?.location?.address ?? ""
        cell.TimeLabel.TextLabel = "\(DetailsArea?.openingHoursFrom ?? "") - \(DetailsArea?.openingHoursTo ?? "")"
        cell.imageView.sd_setImage(with: URL(string: DetailsArea?.coverPhotoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            
        if let rate = DetailsArea?.rate {
        cell.ViewRating.isHidden = false
        cell.ViewRating.setTitle("lang".localizable == "ar" ? "\(rate)".NumAR() : "\(rate)", for: .normal)
        }else{
        cell.ViewRating.isHidden = true
        }
        return cell
            
        case 1:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopId, for: indexPath) as! AreaDetailsTop
        cell.TopData = DetailsArea?.topCall ?? [TopCall]()
        cell.Delegate = self
        return cell
    
        case 2:
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleId, for: indexPath)
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1774599552, green: 0.3385826945, blue: 0.4175281525, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "\(Utilities) \("Utilities".localizable)"
        Label.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(20))
        Label.frame = cell.bounds
        cell.addSubview(Label)
        return cell
            
        case 3:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsId, for: indexPath) as! AreaDetailsCell
        cell.LabelTitle.text = DetailsArea?.utilitie[indexPath.item].title
        cell.ImageView.sd_setImage(with: URL(string: DetailsArea?.utilitie[indexPath.item].coverPhotoPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
            
        default:
        return UICollectionViewCell()
        }
    }
    
    func AreaDetailsTopSelect(_ indexPath: IndexPath) {
        switch DetailsArea?.topCall[indexPath.item].screenId {
        case 1:
        let Restaurant = RestaurantVC()
        Restaurant.AreaId = DetailsArea?.topCall[indexPath.item].id
        Present(ViewController: self, ToViewController: Restaurant)
        case 2:
        let Retail = RetailVC()
        Retail.AreaId = DetailsArea?.topCall[indexPath.item].id
        Present(ViewController: self, ToViewController: Retail)
        case 3:
        let Events = EventsVC()
        Events.AreaId = DetailsArea?.topCall[indexPath.item].id
        Present(ViewController: self, ToViewController: Events)
        case 4:
        let Library = LibraryVC()
        Library.AreaId = DetailsArea?.topCall[indexPath.item].id
        Present(ViewController: self, ToViewController: Library)
        case 5:
        let Museum = MuseumVC()
        Museum.AreaId = DetailsArea?.topCall[indexPath.item].id
        Present(ViewController: self, ToViewController: Museum)
        case 6:
        let Corporate = CorporateVC()
        Corporate.AreaId = DetailsArea?.topCall[indexPath.item].id
        Present(ViewController: self, ToViewController: Corporate)
        default:
        break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
        let estimatedFrame = DetailsArea?.about?.TextHeight(collectionView.frame.width, font: UIFont.systemFont(ofSize: ControlWidth(15)), Spacing: ControlHeight(1)) ?? 0
        return CGSize(width: collectionView.frame.width , height: estimatedFrame + ControlWidth(340))
            
        case 1:
        return CGSize(width: collectionView.frame.width, height: ControlWidth(190))
            
        case 2:
        return CGSize(width: collectionView.frame.width, height: ControlWidth(50))
            
        case 3:
        return CGSize(width: (collectionView.frame.width / 2) - ControlX(8), height: ControlWidth(160))
            
        default:
        return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 2:
        return ControlX(10)
        default:
        return ControlX(15)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 3 {
        let PlacesUtilities = PlacesUtilitiesVC()
        PlacesUtilities.areaId = id
        PlacesUtilities.utilitiesId = DetailsArea?.utilitie[indexPath.item].id 
        Present(ViewController: self, ToViewController: PlacesUtilities)
        }
    }
    
    var DetailsArea : AreaDetails?
    func GetDetails()  {
//    guard let AreaId = id else{return}
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let api = "\(url + GetAreaDetails)"
//            
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                    "Platform": "I",
//                                    "Lang": "lang".localizable,
//                                    "AreaId": AreaId]
//        
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        
        let data = ["title":"Title String","about":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world ","openingHoursFrom":"05:30 pm","openingHoursTo":"12:30 am","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMbbRddHe_LU2WIntyVgILIeh-C7QlD-1wboSZ3lAsqLQM3_Tg0kFQQJtYlo2Gm0VVGvw&usqp=CAU","rate":3.6,
            "location":["address":"Egyptian Museum","lat":30.008268048942845 ,"long" : 31.2524961092041],
                     
            "topCall" : [["id":"","title":"Test String","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMbbRddHe_LU2WIntyVgILIeh-C7QlD-1wboSZ3lAsqLQM3_Tg0kFQQJtYlo2Gm0VVGvw&usqp=CAU","screenId":1,"screenName":"String"],
                ["id":"","title":"Title String","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMbbRddHe_LU2WIntyVgILIeh-C7QlD-1wboSZ3lAsqLQM3_Tg0kFQQJtYlo2Gm0VVGvw&usqp=CAU","screenId":1,"screenName":"String"],
                ["id":"","title":"Test String","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMbbRddHe_LU2WIntyVgILIeh-C7QlD-1wboSZ3lAsqLQM3_Tg0kFQQJtYlo2Gm0VVGvw&usqp=CAU","screenId":1,"screenName":"String"],
                ["id":"","title":"Test String","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMbbRddHe_LU2WIntyVgILIeh-C7QlD-1wboSZ3lAsqLQM3_Tg0kFQQJtYlo2Gm0VVGvw&usqp=CAU","screenId":1,"screenName":"String"],
                ["id":"","title":"Test String","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMbbRddHe_LU2WIntyVgILIeh-C7QlD-1wboSZ3lAsqLQM3_Tg0kFQQJtYlo2Gm0VVGvw&usqp=CAU","screenId":1,"screenName":"String"],
                ["id":"","title":"Test String","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMbbRddHe_LU2WIntyVgILIeh-C7QlD-1wboSZ3lAsqLQM3_Tg0kFQQJtYlo2Gm0VVGvw&usqp=CAU","screenId":1,"screenName":"String"]],
                     
            "utilitie" : [["id":1,"title":"Test String","rate":3.6,"body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHCoBYouH2PCVwExNd7rNXD07AeSx7-m_yM2Y_-3IUw2ZYvawN9oQfP1yQWVwWweMnwtM&usqp=CAU"],
                ["id":1,"title":"Test String","rate":3.6,"body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHCoBYouH2PCVwExNd7rNXD07AeSx7-m_yM2Y_-3IUw2ZYvawN9oQfP1yQWVwWweMnwtM&usqp=CAU"],
                ["id":1,"title":"Test String","rate":3.6,"body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHCoBYouH2PCVwExNd7rNXD07AeSx7-m_yM2Y_-3IUw2ZYvawN9oQfP1yQWVwWweMnwtM&usqp=CAU"],
                ["id":1,"title":"Test String","rate":3.6,"body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world","coverPhotoPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHCoBYouH2PCVwExNd7rNXD07AeSx7-m_yM2Y_-3IUw2ZYvawN9oQfP1yQWVwWweMnwtM&usqp=CAU"]]
        ] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.DetailsArea = AreaDetails(dictionary: data)
            self.CollectionDetails.SetAnimations()
            self.CollectionDetails.isHidden = false
            self.ViewNoData.isHidden = true
            self.ViewDots.endRefreshing {}
        }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.CollectionDetails.isHidden = true
//    self.SetUpIsError(error, true) {self.GetDetails()}
//    }
    }
    
}

