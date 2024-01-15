//
//  BookConfirmationCell.swift
//  LLDC
//
//  Created by Emojiios on 04/04/2022.
//

import UIKit
import SDWebImage

protocol ReservationsDetailsDelegate {
    func BackPeople(_ Cell:BookConfirmationCell,_ indexPath:IndexPath)
    func BackToHome(_ Cell:BookConfirmationCell)
}

class BookConfirmationCell : UITableViewCell, UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    var Delegate:ReservationsDetailsDelegate?
    var ReservationData : ReservationsDetails? {
        didSet {
        guard let data = ReservationData else { return }
         
        Note.text = data.note ?? ""
        PlaceName.text = data.placeName ?? ""
        LocationLabel.TextLabel = data.areaName ?? ""
        PriceLabel.TextLabel = "\(data.totalBookingFees ?? 0.0)"
        DateLabel.TextLabel =  data.date ?? ""
        TimeLabel.TextLabel = data.time ?? ""
    
        ReservationsImage.sd_setImage(with: URL(string: data.coverPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        PeopleCollection.reloadData()
        }
    }
    
    lazy var ReservationsImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .clear
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var PlaceName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1097276457, green: 0.1182126865, blue: 0.1300852455, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Label
    }()

    lazy var LocationLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "Location"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(15))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(13))
        return View
    }()
    
    lazy var PriceLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "Group 31381"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(12))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(14))
        return View
    }()
        
    lazy var DateLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "calendar"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(13), height: ControlHeight(13))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(13))
        return View
    }()
    
    lazy var TimeLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "clock"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(12))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(13))
        return View
    }()
    
    lazy var LocationPrice : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LocationLabel,PriceLabel])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var DateTime : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [DateLabel,TimeLabel])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LocationPrice,DateTime])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        return Stack
    }()
    
    lazy var PeopleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1097276457, green: 0.1182126865, blue: 0.1300852455, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "People".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Label
    }()
    
    var PeopleId = "People"
    lazy var PeopleCollection: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(PeopleCell.self, forCellWithReuseIdentifier: PeopleId)
        vc.heightAnchor.constraint(equalToConstant: ControlWidth(65)).isActive = true
        vc.contentInset = UIEdgeInsets(top: 0, left: ControlX(2), bottom: 0, right: 0)
        return vc
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ReservationData?.reservation.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeopleId, for: indexPath) as! PeopleCell
        cell.backgroundColor = #colorLiteral(red: 0.9353198409, green: 0.9353198409, blue: 0.9353198409, alpha: 1)
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = .zero
        cell.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        cell.layer.cornerRadius = ControlX(8)
        cell.LabelName.text = ReservationData?.reservation[indexPath.item].fullName
        cell.QrImage.sd_setImage(with: URL(string: ReservationData?.reservation[indexPath.item].qrPath ?? ""), placeholderImage: UIImage(named: "IconQR"))
        cell.ProfileImage.sd_setImage(with: URL(string: ReservationData?.reservation[indexPath.item].profile ?? ""), placeholderImage: UIImage(named: "Profile"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 1.5), height:  collectionView.frame.height - ControlWidth(5))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Delegate?.BackPeople(self, indexPath)
    }
    
    lazy var NoteLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1097276457, green: 0.1182126865, blue: 0.1300852455, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Note".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Label
    }()
    
    lazy var Note : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(16))
        return Label
    }()
    
    lazy var BackToHome : UIButton = {
        let Button = UIButton(type: .system)
        Button.layer.cornerRadius = ControlX(10)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionEdit), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(15))
        return Button
    }()
    
    @objc func ActionEdit() {
        Delegate?.BackToHome(self)
     }
    
    lazy var ViewContent:UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [PlaceName,StackLabel,NoteLabel,Note,PeopleLabel,PeopleCollection,BackToHome])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.spacing = ControlWidth(12)
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var ViewBackground : UIView = {
        let View = UIView()
        View.clipsToBounds = true
        View.layer.shadowRadius = 4
        View.backgroundColor = .white
        View.layer.shadowOpacity = 0.4
        View.layer.shadowOffset = .zero
        View.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        View.layer.cornerRadius = ControlX(12)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.isHidden = true
        
        addSubview(ViewBackground)
        ViewBackground.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(15)).isActive = true
        ViewBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-15)).isActive = true
        ViewBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        ViewBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
        
        ViewBackground.addSubview(ReservationsImage)
        ReservationsImage.heightAnchor.constraint(equalToConstant: ControlWidth(260)).isActive = true
        ReservationsImage.topAnchor.constraint(equalTo: ViewBackground.topAnchor).isActive = true
        ReservationsImage.leadingAnchor.constraint(equalTo: ViewBackground.leadingAnchor).isActive = true
        ReservationsImage.trailingAnchor.constraint(equalTo: ViewBackground.trailingAnchor).isActive = true
        
        addSubview(ViewContent)
        ViewContent.bottomAnchor.constraint(equalTo: ViewBackground.bottomAnchor,constant: ControlX(-15)).isActive = true
        ViewContent.topAnchor.constraint(equalTo: ReservationsImage.bottomAnchor,constant: ControlX(20)).isActive = true
        ViewContent.leadingAnchor.constraint(equalTo: ViewBackground.leadingAnchor,constant: ControlX(15)).isActive = true
        ViewContent.trailingAnchor.constraint(equalTo: ViewBackground.trailingAnchor,constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
