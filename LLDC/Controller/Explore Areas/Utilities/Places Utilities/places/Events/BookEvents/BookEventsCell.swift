//
//  BookEventsCell.swift
//  LLDC
//
//  Created by Emojiios on 26/06/2022.
//

import UIKit

protocol BookEventsDelegate {
    func ActionCancel(_ Cell:BookEventsCell)
    func ActionFamily(_ Cell:BookEventsCell,_ CollectionCell:ReservationsFamilyCell)
    func ActionGuests(_ Cell:BookEventsCell,_ CollectionCell:AddInviteGuestsCell)
//    func ActionGuestsRemove(_ Cell:BookEventsCell,_ CollectionCell:GuestCell)
}

class BookEventsCell: UICollectionViewCell {
    
    var Delegate:BookEventsDelegate?
    lazy var DataLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var Cancel : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.setTitle("X", for: .normal)
        Button.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor
        Button.layer.borderWidth = ControlX(2)
        Button.layer.cornerRadius = ControlX(10)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionCancel), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        Button.titleLabel?.font = UIFont.systemFont(ofSize: ControlWidth(20), weight: .semibold)
        Button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        return Button
    }()
    
    
    @objc func ActionCancel() {
    Delegate?.ActionCancel(self)
    }
    
    lazy var TimeLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(15))
        return Label
    }()
    
    lazy var PriceLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(16))
        return Label
    }()
    
    lazy var SelectFamily : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Select Your Family".localizable
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var Stack1 : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [DataLabel,Cancel])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(10)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var Stack2 : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TimeLabel,PriceLabel])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(10)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var StackTop : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Stack1,Stack2,SelectFamily])
        Stack.axis = .vertical
        Stack.spacing = ControlX(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    
    var Events = BookEvents() {
        didSet {
        BookCollection.reloadData()
        }
    }
    let GuestsId = "GuestsId"
    let FamilyId = "FamilyId"
    let InviteGuestsId = "InviteGuestsId"
    lazy var BookCollection: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.isScrollEnabled = false
        vc.showsVerticalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(GuestCell.self, forCellWithReuseIdentifier: GuestsId)
        vc.register(ReservationsFamilyCell.self, forCellWithReuseIdentifier: FamilyId)
        vc.register(AddInviteGuestsCell.self, forCellWithReuseIdentifier: InviteGuestsId)
//        vc.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
//        vc.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        return vc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

        addSubview(StackTop)
        StackTop.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(10)).isActive = true
        StackTop.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlY(15)).isActive = true
        StackTop.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlY(-15)).isActive = true
        StackTop.heightAnchor.constraint(equalToConstant: ControlWidth(110)).isActive = true
        
        addSubview(BookCollection)
        BookCollection.topAnchor.constraint(equalTo: StackTop.bottomAnchor, constant: ControlY(10)).isActive = true
        BookCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlY(15)).isActive = true
        BookCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlY(-15)).isActive = true
        BookCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlY(-10)).isActive = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookEventsCell: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource , AddFamilyDelegate, AddGuestsDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (Events.Family?.count ?? 0) + 1
        case 1:
            return 1
        case 2:
//            return Events.Guests?.count ?? 0
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
        cell.LabelName.text = Events.ProfileData?.fullName
        cell.CheckboxButton.Select(IsSelect: Events.ProfileData?.Select ?? false , text: "")
        cell.ProfileImage.sd_setImage(with: URL(string: Events.ProfileData?.profileImg ?? ""), placeholderImage: UIImage(named: "Profile"))
        }else{
        cell.LabelName.text = Events.Family?[indexPath.item - 1].fullName
        cell.CheckboxButton.Select(IsSelect: !(Events.Family?[indexPath.item - 1].Select ?? false) , text: "")
        cell.ProfileImage.sd_setImage(with: URL(string: Events.Family?[indexPath.item - 1].profileImg ?? ""), placeholderImage: UIImage(named: "Profile"))
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
//        cell.Delegate = self
//        cell.LabelName.text = Events.Guests?[indexPath.item].fName
//        cell.LabelNumber.text = Events.Guests?[indexPath.item].phoneNumber1
            
        cell.Stack.isHidden = true
        cell.ButtonRemove.isHidden = true
        cell.layer.cornerRadius = ControlX(10)
        let count = "lang".localizable == "ar" ? "\(Events.Guests?.count ?? 0)".NumAR() : "\(Events.Guests?.count ?? 0)"
        cell.LabelSelected.text = "\("Selected Guests".localizable)  (\(count))"

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
        return CGSize(width: collectionView.frame.width , height: ControlWidth(60))
        case 2:
//        return CGSize(width: collectionView.frame.width , height: indexPath.item == 0 ? ControlWidth(100) : ControlWidth(50))
        return CGSize(width: collectionView.frame.width , height: ControlWidth(50))
        default:
        return .zero
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        switch section {
//        case 2:
////        return CGSize(width: collectionView.frame.width , height: Events.Guests == nil || Events.Guests?.count == 0 ? 0 : ControlWidth(10))
//        default:
//        return .zero
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        switch section {
//        case 2:
////        return CGSize(width: collectionView.frame.width , height: Events.Guests == nil || Events.Guests?.count == 0 ? 0 : ControlWidth(10))
//        default:
//        return .zero
//        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//    switch kind {
//    case UICollectionView.elementKindSectionHeader:
//    let Header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
//    Header.backgroundColor = .clear
//    Header.roundCorners(corners: [.topLeft,.topRight], radius: ControlX(12), fillColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, 0)
//
//    return Header
//    case UICollectionView.elementKindSectionFooter:
//    let Footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
//    Footer.backgroundColor = .clear
//    Footer.roundCorners(corners: [.bottomLeft,.bottomRight], radius: ControlX(12), fillColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, 0)
//
//    return Footer
//    default:
//    fatalError("Unexpected element kind")
//    }
//    }
    
    func AddFamily(_ Cell:ReservationsFamilyCell) {
    Delegate?.ActionFamily(self,Cell)
    }
    
//    func ActionRemove(_ Cell: GuestCell) {
//    Delegate?.ActionGuestsRemove(self, Cell)
//    }

    func AddGuests(_ Cell:AddInviteGuestsCell) {
    Delegate?.ActionGuests(self,Cell)
    }
    
}

  
