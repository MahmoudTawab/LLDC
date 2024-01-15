//
//  BookVC.swift
//  LLDC
//
//  Created by Emojiios on 16/06/2022.
//

import UIKit
import SDWebImage

class BookVC : ViewController {

    var Total:Double?
    var placesId:String?
    var openingHoursFrom : String?
    var openingHoursTo : String?
    var MemberId = [FamilyMember]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        
        if let sqlId = ProfileData.sqlId {
        MemberId.append(FamilyMember(memberId: sqlId))
        }
        
        for item in ProfileData.Family {
        if let id = item.id {
        MemberId.append(FamilyMember(memberId: id))
        }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BookCollection.reloadData()
    }
    
    func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Dismiss.TextLabel = "Book Table".localizable
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))

        view.addSubview(FamilySelect)
        FamilySelect.topAnchor.constraint(equalTo: Dismiss.bottomAnchor, constant: ControlY(10)).isActive = true
        FamilySelect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
        FamilySelect.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        FamilySelect.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        
        view.addSubview(BookCollection)
        BookCollection.topAnchor.constraint(equalTo: FamilySelect.bottomAnchor, constant: ControlY(10)).isActive = true
        BookCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
        BookCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        BookCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    lazy var FamilySelect : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Select Your Family".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    var FamilyId = "FamilyId"
    let GuestsId = "GuestsId"
    let FooterId = "FooterId"
    let ProfileData = getProfileObject()
    let InviteGuestsId = "InviteGuestsId"
    lazy var BookCollection: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.keyboardDismissMode = .interactive
        vc.showsVerticalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(GuestCell.self, forCellWithReuseIdentifier: GuestsId)
        vc.register(BookFooter.self, forCellWithReuseIdentifier: FooterId)
        vc.register(ReservationsFamilyCell.self, forCellWithReuseIdentifier: FamilyId)
        vc.register(AddInviteGuestsCell.self, forCellWithReuseIdentifier: InviteGuestsId)
        vc.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        vc.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(10), right: 0)
        return vc
    }()
    

}

extension BookVC: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource , AddFamilyDelegate ,AddGuestsDelegate ,GuestCellDelegate ,BookFooterDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
        return ProfileData.Family.count + 1
        case 1:
        return 1
        case 2:
        return InviteGuestsSelected.Guests.count
        case 3:
        return 1
        default:
        return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FamilyId, for: indexPath) as! ReservationsFamilyCell
        cell.Delegate = self
            
        if indexPath.item == 0 {
        cell.LabelName.text = ProfileData.fullName
        cell.CheckboxButton.Select(IsSelect: ProfileData.Select , text: "")
        cell.ProfileImage.sd_setImage(with: URL(string: ProfileData.profileImg ?? ""), placeholderImage: UIImage(named: "Profile"))
        }else{
        cell.LabelName.text = ProfileData.Family[indexPath.item - 1].fullName
        cell.CheckboxButton.Select(IsSelect: ProfileData.Family[indexPath.item - 1].Select , text: "")
        cell.ProfileImage.sd_setImage(with: URL(string: ProfileData.Family[indexPath.item - 1].profileImg ?? ""), placeholderImage: UIImage(named: "Profile"))
        }
        return cell
            
        case 1:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InviteGuestsId, for: indexPath) as! AddInviteGuestsCell
        cell.backgroundColor = .clear
        cell.Delegate = self
            
        return cell
        case 2:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GuestsId, for: indexPath) as! GuestCell
        cell.backgroundColor = .white
        cell.Delegate = self
            
        cell.LabelName.text = InviteGuestsSelected.Guests[indexPath.item].fName
        cell.LabelNumber.text = InviteGuestsSelected.Guests[indexPath.item].phoneNumber1
        let count = "lang".localizable == "ar" ? "\(InviteGuestsSelected.Guests.count)".NumAR() : "\(InviteGuestsSelected.Guests.count)"
        cell.LabelSelected.text = "\("Selected Guests".localizable)  (\(count))"
            
        return cell
        case 3:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FooterId, for: indexPath) as! BookFooter
        cell.SetTotal(Total: "\(Double(MemberId.count + InviteGuestsSelected.Guests.count) * (Total ?? 0.0))")
        cell.backgroundColor = .clear
        cell.Book = self
        cell.Delegate = self
            
        return cell
        default:
        return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
        return CGSize(width: (collectionView.frame.width / 2) - ControlWidth(5), height: ControlWidth(50))
        case 1:
        return CGSize(width: collectionView.frame.width , height: ControlWidth(70))
        case 2:
        return CGSize(width: collectionView.frame.width , height: indexPath.item == 0 ? ControlWidth(100) : ControlWidth(50))
        case 3:
        return CGSize(width: collectionView.frame.width , height: ControlWidth(290))
        default:
        return .zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch section {
        case 2:
        return CGSize(width: collectionView.frame.width , height: InviteGuestsSelected.Guests.count == 0 ? 0 : ControlWidth(10))
        default:
        return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 2:
        return CGSize(width: collectionView.frame.width , height: InviteGuestsSelected.Guests.count == 0 ? 0 : ControlWidth(10))
        default:
        return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
    let Header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
    Header.backgroundColor = .clear
    Header.roundCorners(corners: [.topLeft,.topRight], radius: ControlX(12), fillColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, 0)
        
    return Header
    case UICollectionView.elementKindSectionFooter:
    let Footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
    Footer.backgroundColor = .clear
    Footer.roundCorners(corners: [.bottomLeft,.bottomRight], radius: ControlX(12), fillColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, 0)
        
    return Footer
    default:
    fatalError("Unexpected element kind")
    }
    }
    
    func AddFamily(_ Cell:ReservationsFamilyCell) {
        if let index = BookCollection.indexPath(for: Cell) {
        if index.item == 0 {
        ProfileData.Select = !ProfileData.Select
        Cell.CheckboxButton.Select(IsSelect: ProfileData.Select , text: "")
            
        if let sqlId = ProfileData.sqlId {
        if ProfileData.Select == true {
        MemberId.append(FamilyMember(memberId: sqlId))
        self.BookCollection.reloadData()
        }else{
        MemberId.removeAll(where: {$0.memberId == sqlId})
        self.BookCollection.reloadData()
        }
        }
        }else{
        ProfileData.Family[index.item - 1].Select = !ProfileData.Family[index.item - 1].Select
        Cell.CheckboxButton.Select(IsSelect: ProfileData.Family[index.item - 1].Select , text: "")
        self.BookCollection.reloadItems(at: [IndexPath(item: index.item, section: index.section)])
            
        if let id = ProfileData.Family[index.item - 1].id {
        if ProfileData.Family[index.item - 1].Select == true {
        MemberId.append(FamilyMember(memberId: id))
        self.BookCollection.reloadData()
        }else{
        MemberId.removeAll(where: {$0.memberId == id})
        self.BookCollection.reloadData()
        }
        }
        }
        }
    }
    
    func ActionRemove(_ Cell: GuestCell) {
    if let index = BookCollection.indexPath(for: Cell) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
    InviteGuestsSelected.IdSelect.remove(at: index.item)
    InviteGuestsSelected.Image.remove(at: index.item)
    InviteGuestsSelected.Guests.remove(at: index.item)
    self.BookCollection.deleteItems(at:[index])
    self.BookCollection.reloadData()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    self.BookCollection.reloadData()
    }
    }
    }
    }

    func AddGuests(_ Cell:AddInviteGuestsCell) {
    let InviteGuests = InviteGuestsVC()
    InviteGuests.IdSelect = InviteGuestsSelected.IdSelect
    Present(ViewController: self, ToViewController: InviteGuests)
    }
    
    
    func ActionBook(Cell: BookFooter) {
        if MemberId.count != 0 {
        if Cell.DateTF.NoError() && Cell.TimeTF.NoError() {
        guard let placesId = placesId else{return}
        guard let url = defaults.string(forKey: "API") else{
        LodBaseUrl()
        ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
        return
        }

        let note = Cell.NotesTF.text ?? ""
        let sqlId = getProfileObject().sqlId ?? ""
        let token = defaults.string(forKey: "jwt") ?? ""
        let api = "\(url + RestaurantBookReservationByClient)"
        let DatePicker = Cell.DatePicker.date.Formatter("yyyy-MM-dd'T'HH:mm")
        let Total = Double(MemberId.count + InviteGuestsSelected.Guests.count) * (Total ?? 0.0)

        let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                       "Platform": "I",
                                       "SqlId": sqlId,
                                       "lang": "lang".localizable,
                                       "placesId": placesId,
                                       "note": note,
                                       "DateAndTime": DatePicker,
                                       "TotalBookingFees": Total,
                                       "familyMember": DataAsArray(MemberId),
                                       "guests": DataAsArray(InviteGuestsSelected.Guests)]

        self.ViewDots.beginRefreshing()
        PostAPI(timeout: 180, api: api, token: token, parameters: parameters) { _ in
        } DictionaryData: { data in
        self.ViewDots.endRefreshing {
        let BookConfirmation = BookConfirmationVC()
        BookConfirmation.Reservation = ReservationsDetails(dictionary: data)
        BookConfirmation.IfNoData()
        BookConfirmation.TableView.reloadData()
        BookConfirmation.BookButtonTitle = "Back to home".localizable
        Present(ViewController: self, ToViewController: BookConfirmation)

        InviteGuestsSelected.IdSelect.removeAll()
        InviteGuestsSelected.Image.removeAll()
        InviteGuestsSelected.Guests.removeAll()
        self.BookCollection.reloadData()
        }
        } ArrayOfDictionary: { _ in
        } Err: { error in
        self.ViewDots.endRefreshing(error, .error) {}
        }
        }
        }else{
        ShowMessageAlert("Error", "Error".localizable, "You must add at least one person".localizable, true, {})
        }
    }
}

  
