//
//  ExploreAreasVC.swift
//  LLDC
//
//  Created by Emojiios on 06/04/2022.
//

import UIKit
import SDWebImage

class ExploreAreasVC: ViewController {
    
    var AreasData = [Jardins]()
    override func viewDidLoad() {
        super.viewDidLoad()
        GetAreas()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
    view.addSubview(StackTop)
    StackTop.frame = CGRect(x: ControlX(15), y: ControlY(40), width: view.frame.width - ControlX(30), height: ControlWidth(40))
        
    view.addSubview(AreasCollection)
    AreasCollection.topAnchor.constraint(equalTo: ExploreLabel.bottomAnchor, constant: ControlY(10)).isActive = true
    AreasCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
    AreasCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-15)).isActive = true
    AreasCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    AddRefreshControl(Scroll: AreasCollection, color: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)) {
    self.GetAreas(Refresh: true)
    }
    }
    
    lazy var ExploreLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Explore Areas".localizable
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()

    lazy var MapButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.backgroundColor = .clear
        Button.setImage(UIImage(named: "Map"), for: .normal)
        Button.setTitle(" \("Map".localizable) ", for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionMap), for: .touchUpInside)
        Button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(18))
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        Button.semanticContentAttribute = "lang".localizable == "ar" ? .forceLeftToRight : .forceRightToLeft 
        Button.setTitleColor(#colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1), for: .normal)
        return Button
    }()
    
    lazy var StackTop : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ExploreLabel,MapButton])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(10)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    
    @objc func ActionMap() {
    Present(ViewController: self, ToViewController: MapVC())
    }

    let AreasId = "Areas"
    lazy var  AreasCollection: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ControlWidth(5)
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.isHidden = true
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsVerticalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(JardinsCell.self, forCellWithReuseIdentifier: AreasId)
        vc.contentInset = UIEdgeInsets(top: ControlX(10), left: 0, bottom: ControlX(15), right: 0)
        return vc
    }()

}

extension ExploreAreasVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AreasData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  AreasId,for: indexPath) as! JardinsCell

        cell.BackgroundHeight2?.isActive = true
        cell.BackgroundHeight1?.isActive = false
        cell.JardinsLabel.text = AreasData[indexPath.item].title
        cell.TopBackground?.isActive = indexPath.item % 2 != 0 ? true:false
        cell.BottomBackground?.isActive = indexPath.item % 2 != 0 ? false:true
        cell.JardinsLabel.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(22))
        cell.ViewBackground.backgroundColor = AreasData[indexPath.item].background?.hexStringToUIColor()
        cell.ImageView.sd_setImage(with: URL(string: AreasData[indexPath.item].iconPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
    } 

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - ControlWidth(5), height: ControlWidth(200))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     let AreaDetails = AreaDetailsVC()
    AreaDetails.id = AreasData[indexPath.item].id
    AreaDetails.Utilities = AreasData[indexPath.item].title ?? ""
    Present(ViewController: self, ToViewController: AreaDetails)
    }
    
    
    @objc func GetAreas(Refresh: Bool = false) {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let api = "\(url + GetListAreas)"
//        
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                   "Platform": "I",
//                                   "Lang": "lang".localizable]

    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { ـ in
//    } ArrayOfDictionary: { data in
        
        
        let data = [
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#EC7063"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#AF7AC5"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#5499C7"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#48C9B0"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#52BE80"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#58D68D"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#F4D03F"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#EC7063"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#AF7AC5"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#5499C7"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#48C9B0"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#52BE80"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#58D68D"],
            ["id" : 1,"title" : "Title","iconPath" : "https://icon-library.com/images/cute-ghost-icon/cute-ghost-icon-8.jpg","background" : "#F4D03F"]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            if Refresh {
            self.AreasCollection.RemoveAnimations {
            self.AreasData.removeAll()
            self.AddData(data)
            }
            }else{
            self.AddData(data)
            }
        }
        
//    } Err: { error in
//    self.IfNoData()
//    self.SetUpIsError(error, true) {
//    self.GetAreas(Refresh:Refresh)}
//    }
    }
    
    func AddData(_ dictionary:[[String:Any]]) {
    for item in dictionary {self.AreasData.append(Jardins(dictionary: item))}
    self.AreasCollection.refreshControl?.endRefreshing()
    self.AreasCollection.SetAnimations()
    self.ViewDots.endRefreshing {}
    self.IfNoData()
    }
    
    func IfNoData() {
    self.AreasCollection.isHidden = AreasData.count != 0 ? false : true
    self.ViewNoData.isHidden = AreasData.count != 0 ? true : false
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(GetAreas), for: .touchUpInside)
    }
}


