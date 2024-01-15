//
//  ProfileVC.swift
//  LLDC
//
//  Created by Emojiios on 30/03/2022.
//

import UIKit
import SDWebImage

class ProfileVC: ViewController , UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProfileHeaderDelegate ,ProfileFooterDelegate, ProfileImageDelegate ,FamilyCellDelegate {

    let PersonalProfile = ["Email","Phone","Birthday","City","Home Address","Company","Work Location"]
    override func viewDidLoad() {
        super.viewDidLoad()

        SetUpItems()
        GetProfileData()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }

    
    fileprivate func SetUpItems() {
        
    view.addSubview(Dismiss)
    Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.TextLabel = "Profile".localizable
    Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(40), width: view.frame.width - ControlX(30), height: ControlWidth(40))
        
    view.addSubview(ProfileCollection)
    ProfileCollection.topAnchor.constraint(equalTo: Dismiss.bottomAnchor, constant: ControlY(10)).isActive = true
    ProfileCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    ProfileCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    ProfileCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    AddRefreshControl(Scroll: ProfileCollection, color: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)) {
    self.GetProfileData()
    }
    }

    let ImageID = "ImageID"
    let FamilyID = "Family"
    let FriendID = "Friend"
    let ProfileID = "Profile"
    let HeaderID = "HeaderID"
    let FooterID = "FooterID"
    let PersonalData = [[String:Any]()]
    let FamilyData = [[String:Any]()]
    lazy var ProfileCollection: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.isHidden = true
        vc.delegate = self
        vc.dataSource = self
        vc.backgroundColor = .clear
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(FamilyCell.self, forCellWithReuseIdentifier: FamilyID)
        vc.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileID)
        vc.register(ProfileFriend.self, forCellWithReuseIdentifier: FriendID)
        vc.register(ProfileImageCell.self, forCellWithReuseIdentifier: ImageID)
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        vc.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderID)
        vc.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterID)
        return vc
    }()

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return PersonalProfile.count
        case 2:
            return ProfileData?.profile?.Family.count ?? 0
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let Color = #colorLiteral(red: 0.9558447003, green: 0.9558447003, blue: 0.9558447003, alpha: 1).cgColor
        
    switch indexPath.section {
    case 0:
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageID, for: indexPath) as! ProfileImageCell
    cell.Delegate = self
    cell.LabelName.text = ProfileData?.profile?.fullName
    cell.ProfileImage.sd_setImage(with: URL(string: ProfileData?.profile?.profileImg ?? ""), placeholderImage: UIImage(named: "Profile"))
    if ProfileData?.profile?.isplatinium == true {
    cell.ProfileEdit.isHidden = false
    cell.ProfileEdit.sd_setImage(with: URL(string: ProfileData?.profile?.iconPath ?? ""), placeholderImage: UIImage(named: "Menu1"))
    }else{
    cell.ProfileEdit.isHidden = true
    }
    return cell
    case 1:
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileID, for: indexPath) as! ProfileCell
    cell.LeftLabel.text = PersonalProfile[indexPath.item]
        
    switch indexPath.item {
    case 0:
    cell.RightLabel.text = ProfileData?.profile?.email
    case 1:
    cell.RightLabel.text = ProfileData?.profile?.phone
    case 2:
    cell.RightLabel.text = ProfileData?.profile?.birthday
    case 3:
    cell.RightLabel.text = ProfileData?.profile?.city
    case 4:
    cell.RightLabel.text = ProfileData?.profile?.homeAddress
    case 5:
    cell.RightLabel.text = ProfileData?.profile?.company
    case 6:
    cell.RightLabel.text = ProfileData?.profile?.workLocation
    default:
    break
    }
 
    if indexPath.item == max(0, collectionView.numberOfItems(inSection: 1) - 1) {
    cell.roundCorners(corners: [.bottomLeft,.bottomRight], radius: ControlWidth(8), fillColor: Color, 0)
    }else{
    cell.layer.removeAllAnimations()
    }
    return cell
    case 2:
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FamilyID, for: indexPath) as! FamilyCell
    cell.Delegate = self
    cell.LabelName.text = ProfileData?.profile?.Family[indexPath.item].fullName
    cell.LabelPhone.text = ProfileData?.profile?.Family[indexPath.item].phone
    cell.ProfileImage.sd_setImage(with: URL(string: ProfileData?.profile?.Family[indexPath.item].profileImg ?? ""), placeholderImage: UIImage(named: "Profile"))
    if indexPath.item == max(0, collectionView.numberOfItems(inSection: 2) - 1) {
    cell.roundCorners(corners: [.bottomLeft,.bottomRight], radius: ControlWidth(8), fillColor: Color, 0)
    }else{
    cell.layer.removeAllAnimations()
    }
    return cell
    case 3:
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendID, for: indexPath) as! ProfileFriend
    cell.Delegate = self
    cell.Profile = self
    return cell
    default:
    return UICollectionViewCell()
    }
    }
    
    //  Edit
    func ProfileEdit() {
    PresentToEdit()
    }
    
    // Friend
    func ActionRecommendFriend(cell:ProfileFriend,First: String, Last: String, Phone: String, email: String) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    guard let senderName = ProfileData?.profile?.fullName else { return }
    guard let SqlId = getProfileObject().sqlId else { return }
        
    let api = "\(url + AddRecommendFriend)"
    let token = defaults.string(forKey: "jwt") ?? ""

    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                   "platform": "I",
                                   "lang": "lang".localizable,
                                   "sqlId": SqlId,
                                   "senderName": senderName,
                                   "fName": First,
                                   "lName": Last,
                                   "phone": Phone,
                                   "email": email]
                
    ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.ViewDots.endRefreshing("Success Add Friend".localizable, .success) {
    cell.PhoneNumberTF.text = ""
    cell.FirstName.text = ""
    cell.LastName.text = ""
    cell.EmailTF.text = ""
    }
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing() {}
    if error != "" {
    ShowMessageAlert("Error", "Error".localizable, error, false, {
    self.ActionRecommendFriend(cell: cell,First: First, Last: Last, Phone: Phone, email: email)
    })
    }
    }
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderID, for: indexPath) as! ProfileHeader
        
    switch indexPath.section {
    case 1:
    header.EditButton.image = UIImage(named: "edit")
    header.titleLabel.text = "Personal data".localizable
    case 2:
    header.EditButton.image = UIImage(named: "add")
    header.titleLabel.text = "Family".localizable
    default:
    header.EditButton.image = UIImage()
    header.titleLabel.text = ""
    }

    header.section = indexPath.section
    header.Delegate = self
    return header
        
    case UICollectionView.elementKindSectionFooter:
    let Footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterID, for: indexPath)
    Footer.backgroundColor = .clear
    return Footer
    default:
    fatalError("Unexpected element kind")
    }
    }
    
    
    // Header
    func toggleSection(_ section: Int) {
    switch section {
    case 0,1:
    PresentToEdit()
    case 2:
    let AddFamily = AddFamilyVC()
    AddFamily.Profile = self
    AddFamily.isValidNumber = false
    AddFamily.EmailTF.alpha = 1
    AddFamily.EmailTF.isEnabled = true
    AddFamily.Dismiss.TextLabel = "Add Family".localizable
    Present(ViewController: self, ToViewController: AddFamily)
    default:
    break
    }
    }
    
    
    func ActionEdit(_ Cell: FamilyCell) {
        if let index = self.ProfileCollection.indexPath(for: Cell) {
        let EditFamily = AddFamilyVC()
        EditFamily.Profile = self
        EditFamily.isValidNumber = true
        EditFamily.EmailTF.alpha = 0.6
        EditFamily.EmailTF.isEnabled = false
        EditFamily.Dismiss.TextLabel = "Edit Family".localizable
        EditFamily.ProfileImage.image = Cell.ProfileImage.image
        EditFamily.memberId = self.ProfileData?.profile?.Family[index.item].id
        EditFamily.FullName.text = self.ProfileData?.profile?.Family[index.item].fullName
        EditFamily.PhoneNumberTF.text = self.ProfileData?.profile?.Family[index.item].phone
        EditFamily.EmailTF.text = self.ProfileData?.profile?.Family[index.item].email
        EditFamily.BirthdayTF.text = self.ProfileData?.profile?.Family[index.item].birthday
        EditFamily.RelationId = self.ProfileData?.profile?.Family[index.item].relationId
        EditFamily.memberPhoto = self.ProfileData?.profile?.Family[index.item].profileImg
        Present(ViewController: self, ToViewController: EditFamily)
        }
    }
    
    func ActionRemove(_ Cell: FamilyCell) {
    ShowMessageAlert("Error", "Delete".localizable + " " + "Family".localizable, "Do you really want to delete a family member".localizable, false, {
            
    if let index = self.ProfileCollection.indexPath(for: Cell) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    let api = "\(url + DeleteFamilyMember)"
                    
    guard let memberId = self.ProfileData?.profile?.Family[index.item].id else { return }
    guard let SqlId = getProfileObject().sqlId else { return }
    let token = defaults.string(forKey: "jwt") ?? ""
                
    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                    "platform": "I",
                                    "lang": "lang".localizable,
                                    "sqlId": SqlId,
                                    "memberId": memberId]
                        

    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.ProfileData?.profile?.Family.remove(at: index.item)
    self.ProfileCollection.deleteItems(at: [IndexPath(item: index.item, section: 2)])
    self.ViewDots.endRefreshing() {}
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }
        
    }, "Delete".localizable)
    }
    
    func PresentToEdit() {
    let EditPersonal =  EditPersonalVC()
    EditPersonal.Profile = self
    EditPersonal.imageUrl = ProfileData?.profile?.profileImg
    EditPersonal.cityId = ProfileData?.profile?.cityId
    EditPersonal.FullName.text = ProfileData?.profile?.fullName
    EditPersonal.EmailTF.text = ProfileData?.profile?.email
    EditPersonal.PhoneNumberTF.text = ProfileData?.profile?.phone
    EditPersonal.BirthdayTF.text = ProfileData?.profile?.birthday
    EditPersonal.CityTF.text = ProfileData?.profile?.city
    EditPersonal.HomeAddressTF.text = ProfileData?.profile?.homeAddress
    EditPersonal.CompanyTF.text = ProfileData?.profile?.company
    EditPersonal.WorkLocationTF.text = ProfileData?.profile?.workLocation
    EditPersonal.GenderTF.text = ProfileData?.profile?.male == false ? "FeMale".localizable : "Male".localizable
    Present(ViewController: self, ToViewController: EditPersonal)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    switch section {
    case 0,1,max(0, collectionView.numberOfSections - 1):
    return CGSize(width: collectionView.frame.width , height: ControlWidth(20))
    case 2:
    if ProfileData?.profile?.memberTypeId == 5 {
    return .zero
    }else{
    return CGSize(width: collectionView.frame.width - ControlX(30), height: ControlWidth(55))
    }
    default:
    return .zero
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    switch section {
    case 0,max(0, collectionView.numberOfSections - 1):
    return .zero
    case 1:
    return CGSize(width: collectionView.frame.width - ControlX(30), height: ControlWidth(55))
    case 2:
    if ProfileData?.profile?.memberTypeId == 5 {
    return .zero
    }else{
    return CGSize(width: collectionView.frame.width - ControlX(30), height: ControlWidth(55))
    }
    default:
    return .zero
    }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.section {
    case 0:
    return CGSize(width: collectionView.frame.width - ControlX(30), height: ControlWidth(70))
    case 1:
    return CGSize(width: collectionView.frame.width - ControlX(30), height: ControlWidth(55))
    case 2:
    if ProfileData?.profile?.memberTypeId == 5 {
    return .zero
    }else{
    return CGSize(width: collectionView.frame.width - ControlX(30), height: ControlWidth(55))
    }
        
    case max(0, collectionView.numberOfSections - 1):
    return CGSize(width: collectionView.frame.width - ControlX(30), height: ControlWidth(330))
    default:
    return .zero
    }
    }
    
    var ProfileData :Main?
    static let ProfileNotification = NSNotification.Name(rawValue: "Profile")
    func GetProfileData() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    guard let SqlId = getProfileObject().sqlId else { return }
//        
//    let api = "\(url + GetProfile)"
//    let token = defaults.string(forKey: "jwt") ?? ""
//        
//    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                   "platform": "I",
//                                   "lang": "lang".localizable,
//                                   "sqlId": SqlId]
            
    ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        
        let data = [
        "profile": [
            "uid": "","sqlId": "","fullName": "Mahmoud Tawab","email": "Mahmoud@mail.com","phone": "01204474410","emailVerified": true,"phoneVerified": true,"male": true,"birthday": "23/10/1997","cityId": 1,"city": "Cairo","homeAddress": "AIRO, Street","linkedIn": "","facebook": "","instagram": "","qrPath": "","receiveNotifications": false,"receiveEmail": true,"company": "Test company","workLocation": "El Mokattam 151","memberTypeId": 1,"memberType": "","profileImg": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAlpQBahpDZSNYA6W-nCeQlpF_RcoYkAbdSg&usqp=CAU","iconPath": "2","isplatinium": true,
            
        "familyMembers" : [
            [
                "id": "","email": "tawab@mail.com","fullName": "tawab hosny","profileImg": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK0EztGrrGWCA9CYjGkTmcQEmmqdDQaxLvQg&usqp=CAU","phone": "01204474410","birthday": ""
                ,"activated" : true
                ,"relationId": 1
                ,"relation": "1"
                ,"createdIn": ""
            ],
            [
            "id": "","email": "Hosny@mail.com","fullName": "Hosny Mahmoud","profileImg": "https://cdn2.steamgriddb.com/icon_thumb/798fa73dc39804b96742e2d3e6c5343a.png","phone": "01204474410","birthday": ""
            ,"activated" : true
            ,"relationId": 2
            ,"relation": "2"
            ,"createdIn": ""
            ],
            [
            "id": "","email": "Ali@mail.com","fullName": "Ali","profileImg": "https://pics.craiyon.com/2023-07-01/c45e62641e1e42e1813ccbd239020726.webp","phone": "01204474410","birthday": ""
            ,"activated" : true
            ,"relationId": 3
            ,"relation": "3"
            ,"createdIn": ""
            ]]
        ]] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.ProfileCollection.refreshControl?.endRefreshing()
            self.ProfileCollection.RemoveAnimations {
                self.ProfileData = nil
                self.ProfileCollection.reloadData()
                
                self.ProfileData = Main(dictionary: data)
                self.ViewDots.endRefreshing() {}
                self.ViewNoData.isHidden = true
                self.ProfileCollection.isHidden = false
                self.ProfileCollection.SetAnimations()
                NotificationCenter.default.post(name: ProfileVC.ProfileNotification, object: nil)
            }
        }
        
//    } ArrayOfDictionary: { dictionary in
//    } Err: { error in
//    self.ProfileCollection.isHidden = true
//    self.SetUpIsError(error, true, self.GetProfileData)
//    self.ProfileCollection.refreshControl?.endRefreshing()
//    }
    }
    

}
