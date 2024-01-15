//
//  BookEventsVC.swift
//  LLDC
//
//  Created by Emojiios on 24/06/2022.
//

import UIKit

class BookEventsVC: ViewController {
    
    var Total = Double()
    var PlacesId : String?
    var Guests : IndexPath?
    var MembersId = Int()
    var GuestsCount = Int()
    var IndexGuests : IndexPath?
    var EventsSelect = [Events]()
    var EventsData = [BookEvents]()
    var DaysSelect = [PlaceSchedule]()

    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Dismiss.TextLabel = "Book Table".localizable
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))

        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: ControlX(15), y: Dismiss.frame.maxY + ControlY(10) , width: view.frame.width - ControlX(30), height: view.frame.height - ControlHeight(100))
        
        ViewScroll.addSubview(SelectedData)
        SelectedData.leftAnchor.constraint(equalTo: view.leftAnchor,constant: ControlX(15)).isActive = true
        SelectedData.rightAnchor.constraint(equalTo: view.rightAnchor,constant: ControlX(-15)).isActive = true
        SelectedData.topAnchor.constraint(equalTo: ViewScroll.topAnchor).isActive = true
        SelectedData.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        
        ViewScroll.addSubview(BookCollection)
        BookCollection.leftAnchor.constraint(equalTo: SelectedData.leftAnchor).isActive = true
        BookCollection.rightAnchor.constraint(equalTo: SelectedData.rightAnchor).isActive = true
        BookCollection.topAnchor.constraint(equalTo: SelectedData.bottomAnchor,constant: ControlY(10)).isActive = true
        BookCollection.heightAnchor.constraint(equalToConstant: ControlWidth(310)).isActive = true
//        CollectionConstraint = BookCollection.heightAnchor.constraint(equalToConstant: ControlWidth(260))
//        CollectionConstraint?.isActive = true
       
        ViewScroll.addSubview(FooterView)
        FooterView.leftAnchor.constraint(equalTo: SelectedData.leftAnchor).isActive = true
        FooterView.rightAnchor.constraint(equalTo: SelectedData.rightAnchor).isActive = true
        FooterView.topAnchor.constraint(equalTo: BookCollection.bottomAnchor,constant: ControlY(5)).isActive = true
        FooterView.heightAnchor.constraint(equalToConstant: ControlWidth(190)).isActive = true
        
        EventsData.removeAll()
        for item in DaysSelect {
        EventsData.append(BookEvents(DaysSelect: item, ProfileData: getProfileObject(), Family: getProfileObject().Family, MembersId: [FamilyMember(memberId: getProfileObject().sqlId ?? "")], Guests: nil, GuestsId: nil))
        BookCollection.reloadData()
        SelectedData.text = "Selected Data ".localizable + "\(EventsData.count)"
        
        Total += item.bookingFee ?? 0.0
        self.FooterView.SetTotal(Total: String(Total))
        }
        
        ViewScroll.updateContentViewSize(0)
    }

    lazy var SelectedData : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()
    
    let FooterId = "FooterId"
    let BookEventsId = "BookEventsId"
//    var CollectionConstraint:NSLayoutConstraint!
    lazy var BookCollection : CollectionAnimations = {
        let layout = RTLCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = ControlWidth(10)
        layout.scrollDirection = .horizontal
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(BookEventsCell.self, forCellWithReuseIdentifier: BookEventsId)
        return vc
    }()
    
    lazy var FooterView : BookEventsFooter = {
        let View = BookEventsFooter()
        View.backgroundColor = .clear
        View.Delegate = self
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
}


extension BookEventsVC: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,BookFooterEventsDelegate ,BookEventsDelegate  {
            
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EventsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookEventsId, for: indexPath) as! BookEventsCell
        cell.Delegate = self
        cell.backgroundColor = #colorLiteral(red: 0.8961289525, green: 0.9003779292, blue: 0.8372396827, alpha: 1)
        cell.layer.cornerRadius = ControlX(12)
        cell.Events = EventsData[indexPath.item]
        cell.DataLabel.text = EventsData[indexPath.item].DaysSelect?.startDate?.Formatter().Formatter("dd MMM yyyy")
        cell.PriceLabel.text = "\("Price".localizable) : \(EventsData[indexPath.item].DaysSelect?.bookingFee ?? 0.0) \("LE".localizable)"
        cell.TimeLabel.text = "\(EventsData[indexPath.item].DaysSelect?.openingHoursFrom ?? "") - \(EventsData[indexPath.item].DaysSelect?.openingHoursTo ?? "")"
        return cell
    }
    
    func ActionBook(_ Cell:BookEventsFooter) {
        EventsSelect.removeAll()
        if EventsData.contains(where: { $0.MembersId?.count == 0}) {
        ShowMessageAlert("Error", "Error".localizable, "You must add at least one person".localizable, true, {})
        }else{
        for item in EventsData {
                    
        if let Id = item.DaysSelect?.id {
        EventsSelect.append(Events(scheduleid: Id, familyMember: DataAsArray(item.MembersId), guests: DataAsArray(item.Guests)))
        if EventsSelect.count == EventsData.count {
        guard let placesId = PlacesId else{return}
        guard let url = defaults.string(forKey: "API") else{
        LodBaseUrl()
        ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
        return
        }
            
        let note = Cell.NotesTF.text ?? ""
        let schedule = DataAsAny(EventsSelect)
        let sqlId = getProfileObject().sqlId ?? ""
        let api = "\(url + BookReservationByClient)"
        let token = defaults.string(forKey: "jwt") ?? ""

        let parameters = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                          "Platform": "I",
                          "SqlId": sqlId,
                          "lang": "lang".localizable,
                          "placesId": placesId,
                          "note": note,
                          "TotalBookingFees": Total,
                          "schedule": schedule]
        
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
        }
        }
        }
    }
    
    func ActionCancel(_ Cell: BookEventsCell) {
    if let Index = BookCollection.indexPath(for: Cell) {
    Total -= (EventsData[Index.item].DaysSelect?.bookingFee ?? 0.0) * Double(EventsData[Index.item].MembersId?.count ?? 0)
    self.FooterView.SetTotal(Total: String(Total))
        
    EventsData.remove(at: Index.item)
    BookCollection.deleteItems(at: [Index])
    SelectedData.text = "Selected Data ".localizable + "\(EventsData.count)"
//    CollectionHeight()
        
    if EventsData.count == 0 {
    self.navigationController?.popViewController(animated: true)
    }
    }
    }
    
    
    func ActionFamily(_ Collection: BookEventsCell, _ CollectionCell: ReservationsFamilyCell) {
    if let Index = BookCollection.indexPath(for: Collection) {
    if let index = Collection.BookCollection.indexPath(for: CollectionCell) {
    if index.item == 0 {
    EventsData[Index.item].ProfileData?.Select = !(EventsData[Index.item].ProfileData?.Select ?? false)
    
    if let sqlId = EventsData[Index.item].ProfileData?.sqlId {
    if EventsData[Index.item].ProfileData?.Select == true {
    Total += EventsData[Index.item].DaysSelect?.bookingFee ?? 0.0
    self.FooterView.SetTotal(Total: String(Total))
        
    EventsData[Index.item].MembersId?.append(FamilyMember(memberId: sqlId))
    BookCollection.reloadData()
    
    }else{
    Total -= EventsData[Index.item].DaysSelect?.bookingFee ?? 0.0
    self.FooterView.SetTotal(Total: String(Total))
        
    EventsData[Index.item].MembersId?.removeAll(where: {$0.memberId == sqlId})
    BookCollection.reloadData()
    }
    }
    
    }else{
    EventsData[Index.item].Family?[index.item - 1].Select = !(EventsData[Index.item].Family?[index.item - 1].Select ?? false)
    
    if let id = EventsData[Index.item].Family?[index.item - 1].id {
    if EventsData[Index.item].Family?[index.item - 1].Select == false {
        
    Total += EventsData[Index.item].DaysSelect?.bookingFee ?? 0.0
    self.FooterView.SetTotal(Total: String(Total))
        
    EventsData[Index.item].MembersId?.append(FamilyMember(memberId: id))
    BookCollection.reloadData()
    }else{
        
    Total -= EventsData[Index.item].DaysSelect?.bookingFee ?? 0.0
    self.FooterView.SetTotal(Total: String(Total))
        
    EventsData[Index.item].MembersId?.removeAll(where: {$0.memberId == id})
    BookCollection.reloadData()
    }
    }
    }
    }
    }
    }
    
    
    func ActionGuests(_ Collection: BookEventsCell, _ CollectionCell: AddInviteGuestsCell) {
    if let Index = BookCollection.indexPath(for: Collection) {
    Guests = Index
    let InviteGuests = InviteGuestsVC()
    InviteGuestsSelected.Guests.removeAll()
    InviteGuestsSelected.IdSelect.removeAll()
    InviteGuestsSelected.Image.removeAll()
    GuestsCount = EventsData[Index.item].Guests?.count ?? 0
    InviteGuests.IdSelect = EventsData[Index.item].GuestsId ?? [String]()
    Present(ViewController: self, ToViewController: InviteGuests)
    }
    }

//    func ActionGuestsRemove(_ Collection: BookEventsCell, _ CollectionCell: GuestCell) {
//    if let Index = BookCollection.indexPath(for: Collection) {
//    if let index = Collection.BookCollection.indexPath(for: CollectionCell) {
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//    self.Events[Index.item].Guests?.remove(at: index.item)
//    self.Events[Index.item].GuestsId?.remove(at: index.item)
//    Collection.BookCollection.deleteItems(at:[index])
//    self.BookCollection.reloadData()
//    Collection.BookCollection.reloadData()
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//    self.CollectionHeight()
//    self.BookCollection.reloadData()
//    Collection.BookCollection.reloadData()
//    self.FooterTotal()
//    }
//    }
//    }
//    }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if InviteGuestsSelected.Guests.count != 0 {
    if let GuestsItem = Guests {
    EventsData[GuestsItem.item].Guests = InviteGuestsSelected.Guests
    EventsData[GuestsItem.item].GuestsId = InviteGuestsSelected.IdSelect
    BookCollection.reloadSections(IndexSet(integer: 0))
//  self.CollectionHeight()
        
    self.Total -= (self.EventsData[GuestsItem.item].DaysSelect?.bookingFee ?? 0.0) * Double(GuestsCount)
    self.Total += (self.EventsData[GuestsItem.item].DaysSelect?.bookingFee ?? 0.0) * Double(EventsData[GuestsItem.item].Guests?.count ?? 0)
    self.FooterView.SetTotal(Total: String(self.Total))
    }
    }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 1.1, height: collectionView.frame.height)
    }

    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView != ViewScroll {
//        CollectionHeight()
//        }
//    }
//
//    func CollectionHeight() {
//        let visibleRect = CGRect(origin: BookCollection.contentOffset, size: BookCollection.bounds.size)
//        let visiblePoint = CGPoint(x: visibleRect.midX - ControlWidth(20), y: visibleRect.midY)
//        let indexPath = BookCollection.indexPathForItem(at: visiblePoint)
//            if let index = indexPath {
//            if let Cell = BookCollection.cellForItem(at: index) as? BookEventsCell {
//            let Height = Cell.BookCollection.contentSize.height + ControlWidth(150)
//            if Int(self.CollectionConstraint.constant) != Int(Height) {
//            self.BookCollection.scrollToItem(at: index, at: .right, animated: true)
//
//            UIView.animate(withDuration: 0.5) {
//            self.BookCollection.isScrollEnabled = false
//            self.CollectionConstraint.constant = Height
//            self.view.layoutIfNeeded()
//            self.BookCollection.reloadData()
//            Cell.BookCollection.reloadData()
//            self.ViewScroll.updateContentViewSize(0)
//            self.BookCollection.isScrollEnabled = true
//            }
//            }
//            }
//            }
//    }
    
}

