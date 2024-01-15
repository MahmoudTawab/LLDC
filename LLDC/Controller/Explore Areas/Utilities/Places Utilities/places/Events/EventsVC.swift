//
//  EventsVC.swift
//  LLDC
//
//  Created by Emojiios on 13/06/2022.
//

import UIKit
import SDWebImage

class EventsVC: ViewController, ViewCalendarDelegate {
    
    var AreaId : String?
    var thumbs = [Media]()
    var mediaArray = [Media]()
    var Details:PlaceDetails?
    var imageArray = [UIImage]()
    var headerHeightConstraint: NSLayoutConstraint!
    let maxHeaderHeight: CGFloat = ControlHeight(370)
    let minHeaderHeight: CGFloat = ControlHeight(160)
    var previousScrollOffset: CGFloat = 0
    var previousScrollViewHeight: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        
      SetUpItems()
      SetDataEvents()
    }

    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    headerHeightConstraint.constant = maxHeaderHeight
    updateHeader()
    }
    
    fileprivate func SetUpItems() {
    previousScrollViewHeight = EventsTable.contentSize.height
        
    view.addSubview(ViewTop)
    headerHeightConstraint = ViewTop.heightAnchor.constraint(equalToConstant: ControlHeight(370))
    headerHeightConstraint?.isActive = true
    ViewTop.topAnchor.constraint(equalTo: view.topAnchor,constant: -TopHeight).isActive = true
    ViewTop.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    ViewTop.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    ViewTop.addSubview(EventsCollection)
    EventsCollection.topAnchor.constraint(equalTo: ViewTop.topAnchor).isActive = true
    EventsCollection.leadingAnchor.constraint(equalTo: ViewTop.leadingAnchor).isActive = true
    EventsCollection.trailingAnchor.constraint(equalTo: ViewTop.trailingAnchor).isActive = true
    EventsCollection.bottomAnchor.constraint(equalTo: ViewTop.bottomAnchor , constant: ControlHeight(-120)).isActive = true
        
    ViewTop.addSubview(pageControl)
    pageControl.topAnchor.constraint(equalTo: EventsCollection.bottomAnchor,constant: ControlX(20)).isActive = true
    pageControl.leadingAnchor.constraint(equalTo: ViewTop.leadingAnchor,constant: ControlX(15)).isActive = true
    pageControl.trailingAnchor.constraint(equalTo: ViewTop.trailingAnchor,constant: ControlX(-15)).isActive = true
    pageControl.heightAnchor.constraint(equalToConstant: ControlHeight(15)).isActive = true
    pageControl.transform = CGAffineTransform(rotationAngle: "lang".localizable == "ar" ? .pi:0)

    ViewTop.addSubview(AddCalendar)
    AddCalendar.bottomAnchor.constraint(equalTo: EventsCollection.bottomAnchor,constant: ControlY(20)).isActive = true
    AddCalendar.trailingAnchor.constraint(equalTo: ViewTop.trailingAnchor,constant: ControlX(-15)).isActive = true
    AddCalendar.widthAnchor.constraint(equalToConstant: ControlHeight(40)).isActive = true
    AddCalendar.heightAnchor.constraint(equalToConstant: ControlHeight(40)).isActive = true
    AddCalendar.layer.cornerRadius = ControlHeight(20)
        
    ViewTop.addSubview(SavedButton)
    SavedButton.bottomAnchor.constraint(equalTo: EventsCollection.bottomAnchor,constant: ControlY(20)).isActive = true
    SavedButton.trailingAnchor.constraint(equalTo: AddCalendar.leadingAnchor,constant: ControlX(-15)).isActive = true
    SavedButton.widthAnchor.constraint(equalToConstant: ControlHeight(40)).isActive = true
    SavedButton.heightAnchor.constraint(equalToConstant: ControlHeight(40)).isActive = true
    SavedButton.layer.cornerRadius = ControlHeight(20)
                
    ViewTop.addSubview(EventsName)
    EventsName.topAnchor.constraint(equalTo: pageControl.bottomAnchor,constant: ControlX(15)).isActive = true
    EventsName.leadingAnchor.constraint(equalTo: ViewTop.leadingAnchor,constant: ControlX(15)).isActive = true
    EventsName.widthAnchor.constraint(equalToConstant: ControlWidth(160)).isActive = true
    EventsName.heightAnchor.constraint(equalToConstant: ControlHeight(28)).isActive = true
        
    ViewTop.addSubview(ViewRating)
    ViewRating.layer.cornerRadius = ControlHeight(14)
    ViewRating.topAnchor.constraint(equalTo: EventsName.topAnchor).isActive = true
    ViewRating.bottomAnchor.constraint(equalTo: EventsName.bottomAnchor).isActive = true
    ViewRating.leadingAnchor.constraint(equalTo: EventsName.trailingAnchor,constant: ControlX(5)).isActive = true
    ViewRating.widthAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        
    ViewTop.addSubview(StackLabel)
    StackLabel.topAnchor.constraint(equalTo: EventsName.bottomAnchor,constant: ControlX(5)).isActive = true
    StackLabel.leadingAnchor.constraint(equalTo: ViewTop.leadingAnchor,constant: ControlX(15)).isActive = true
    StackLabel.trailingAnchor.constraint(equalTo: ViewTop.trailingAnchor,constant: ControlX(-15)).isActive = true
    StackLabel.heightAnchor.constraint(equalToConstant: ControlHeight(50)).isActive = true
        
    view.addSubview(EventsTable)
    EventsTable.topAnchor.constraint(equalTo: StackLabel.bottomAnchor,constant: ControlX(10)).isActive = true
    EventsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    EventsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    EventsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    view.addSubview(Dismiss)
    Dismiss.Label.alpha = 0
    Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.IconImage.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == EventsTable {
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
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == EventsTable {
        self.scrollViewDidStopScrolling()
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == EventsTable {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
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
        self.EventsTable.contentOffset = CGPoint(x: self.EventsTable.contentOffset.x, y: position)
    }
    
    func updateHeader() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let openAmount = self.headerHeightConstraint.constant - self.minHeaderHeight
        let percentage = openAmount / range
        
        Dismiss.Label.alpha = abs(percentage - 1)
        EventsName.alpha = percentage
        pageControl.alpha = percentage
        SavedButton.alpha = percentage
        AddCalendar.alpha = percentage
        EventsCollection.alpha = percentage
    }
    
    ///
    lazy var ViewTop: UIView = {
        let View = UIView()
      View.isHidden = true
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    let EventsId = "EventsId"
    lazy var EventsCollection : CollectionAnimations = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.delegate = self
        vc.dataSource = self
        vc.isPagingEnabled = true
        vc.backgroundColor = .clear
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(EventsCollectionCell.self, forCellWithReuseIdentifier: EventsId)
        return vc
    }()

    lazy var pageControl:CHIPageControlPuya = {
        let pc = CHIPageControlPuya(frame: CGRect(x: 0, y:0, width: 100, height: 10))
        pc.tintColor = .black
        pc.enableTouchEvents = true
        pc.backgroundColor = .clear
        pc.currentPageTintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        pc.radius = 5
        pc.padding = 10
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.transform = CGAffineTransform(scaleX: ControlWidth(1), y: ControlWidth(1))
        return pc
    }()
    
    lazy var EventsName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var ViewRating : UIButton = {
        let Button = UIButton(type: .system)
        Button.isHidden = true
        Button.backgroundColor = #colorLiteral(red: 0.9409350157, green: 0.9002719522, blue: 0.8440292478, alpha: 1)
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "RatingSelected"), for: .normal)
        Button.addTarget(self, action: #selector(ActionReviews), for: .touchUpInside)
        Button.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Regular", size:  ControlWidth(13))
        return Button
    }()
    
    
    @objc func ActionReviews() {
        let Reviews = ReviewsVC()
        Reviews.PlacesId = self.Details?.id
        Present(ViewController: self, ToViewController: Reviews)
    }
    
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
    
    lazy var DateTime : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [DateLabel,TimeLabel])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LocationLabel,DateTime])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.addBottomLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), height: ControlHeight(1) , space: ControlHeight(6))
        return Stack
    }()
    
    lazy var SavedButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        Button.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        Button.layer.shadowOffset = .zero
        Button.layer.shadowOpacity = 0.4
        Button.layer.shadowRadius = 4
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSaved), for: .touchUpInside)
        Button.setImage(UIImage(named: "Saved")?.withInset(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)), for: .normal)
        return Button
    }()
    
    @objc func ActionSaved() {
        let UrlAddOrRemove = self.Details?.isFavorite == false ? AddFavoritePlaces : RemoveFavoritePlaces
                
        guard let url = defaults.string(forKey: "API") else{
        LodBaseUrl()
        ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
        return
        }
        let sqlId = getProfileObject().sqlId ?? ""
        guard let placesId = AreaId else{return}
        
        let api = "\(url + UrlAddOrRemove)"
        let token = defaults.string(forKey: "jwt") ?? ""

        let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                        "Platform": "I",
                                        "placesId": placesId,
                                        "SqlId": sqlId]

        self.ViewDots.beginRefreshing()
        SavedButton.isUserInteractionEnabled = false
        PostAPI(api: api, token: token, parameters: parameters) { _ in
            
        self.ViewDots.endRefreshing {}
        self.Details?.isFavorite == false ? self.SavedButton.setImage(UIImage(named: "Saved"), for: .normal): self.SavedButton.setImage(UIImage(named: "NotSaved"), for: .normal)
        self.Details?.isFavorite = !(self.Details?.isFavorite ?? false)
        self.SavedButton.isUserInteractionEnabled = true
        } DictionaryData: { _ in
        } ArrayOfDictionary: { _ in
        } Err: { Error in
        self.ViewDots.endRefreshing(Error, .error) {}
        self.SavedButton.isUserInteractionEnabled = true
        }
    }
    
    lazy var AddCalendar : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        Button.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        Button.layer.shadowOffset = .zero
        Button.layer.shadowOpacity = 0.4
        Button.layer.shadowRadius = 4
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionAddCalendar), for: .touchUpInside)
        Button.setImage(UIImage(named: "calendar-add")?.withInset(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)), for: .normal)
        return Button
    }()

    
    let PopUp = PopUpDownView()
    @objc func ActionAddCalendar() {
    PopUp.currentState = .open
    PopUp.modalPresentationStyle = .overFullScreen
    PopUp.modalTransitionStyle = .coverVertical
    PopUp.endCardHeight = ControlWidth(400)
    PopUp.View.backgroundColor = #colorLiteral(red: 0.9215685725, green: 0.9215685725, blue: 0.9215685725, alpha: 1)
    PopUp.radius = 15
        
    let TopView = UIView()
    TopView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    TopView.layer.cornerRadius = ControlX(2)
    PopUp.View.addSubview(TopView)
    TopView.frame = CGRect(x: PopUp.view.center.x - ControlWidth(60), y: ControlX(20), width: ControlWidth(120), height: ControlWidth(4))
        
    let Calendar = ViewCalendar()
    Calendar.Delegate = self
    Calendar.backgroundColor = .clear
    Calendar.ScheduleDate = self.Details?.Schedule ?? [PlaceSchedule]()
    PopUp.View.addSubview(Calendar)
    Calendar.frame = CGRect(x: 0, y: ControlX(30), width: view.frame.width, height: ControlWidth(400))
    present(PopUp, animated: true)
    }
    
    func BookTicket(View:ViewCalendar) {
    if View.DaysSelect.count != 0 {
    PopUp.DismissAction()
    let BookEvents = BookEventsVC()
    BookEvents.PlacesId = self.Details?.id
    BookEvents.DaysSelect = View.DaysSelect
    InviteGuestsSelected.IdSelect.removeAll()
    InviteGuestsSelected.Image.removeAll()
    InviteGuestsSelected.Guests.removeAll()
    Present(ViewController: self, ToViewController: BookEvents)
    }
    }
    
    let cellId = "cellId"
    lazy var EventsTable : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.delegate = self
        tv.dataSource = self
        tv.isHidden = true
        tv.separatorColor = .clear
        tv.backgroundColor = .clear
        tv.showsVerticalScrollIndicator = false
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(EventsTableCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()

    func IfNoData() {
    self.ViewTop.isHidden = Details != nil ? false : true
    self.ViewNoData.isHidden = Details != nil ? true : false
    self.EventsTable.isHidden = Details != nil ? false : true
    self.EventsTable.SetAnimations()
    self.EventsCollection.SetAnimations()
    self.ViewDots.endRefreshing {}
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(SetDataEvents), for: .touchUpInside)
    }

}

extension EventsVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EventsTableCell
        cell.selectionStyle = .none
        cell.TitleLabel.text = Details?.areaName ?? ""
        cell.DetailLabel.text = Details?.about ?? ""
        cell.DetailLabel.addInterlineSpacing(spacingValue: ControlHeight(5))
        return cell
    }
    
    @objc func SetDataEvents() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let sqlId = getProfileObject().sqlId ?? ""
//    guard let placesId = AreaId else{return}
//
//    let api = "\(url + GetPlaceDetails)"
//    let token = defaults.string(forKey: "jwt") ?? ""
//
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                    "Platform": "I",
//                                    "Lang": "lang".localizable,
//                                    "PlacesId": placesId,
//                                    "SqlId": sqlId]
//
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = ["id":"","screenId":1,"screenName":"","isFavorite":true,"coverPhotoPath":"https://onepagelove.imgix.net/2022/06/opl-screenshot-5.jpg?w=540&max-h=540&fit=crop&fp-y=0&auto=compress","title":"Test String","rate":3.5
                             ,"areaName":"Area Name"
                             ,"subUtilitie":"sub Utilitie"
                             ,"about":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world "
                             ,"openingHoursFrom":"12:30"
                             ,"openingHoursTo":"05:30"
                             ,"startDate":"23/10"
                             ,"bookingFee":3.4
                             ,"bookingSta":true,
                     
                     "schedule":["id":"","startDate":"23/10","openingHoursFrom":"12:30","openingHoursTo":"05:30","bookingFee":3.6,"availableTickets":1],
                     "offers":[["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"],
                               ["id":1,"coverPhotoPath":"https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title":"Title String","about":"About String","expiryDate":"23/10"]],
                     
                     "gallery":[["mediaType":"","mediaPath":"https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg"],
                                ["mediaType":"","mediaPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHg9QPgX1Ugi49mFFsYcWSrsJhRjRYScGyjWLZZUl4UrSvu4MoGrCrWYqWgaiLYV9w5aA&usqp=CAU"],
                                ["mediaType":"","mediaPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAK92MyGos-U-fuF8VLWE530y7FuULP9yr4GCmJ_laIMvwX4HVa7XvcP8wo2BaIlpUtDI&usqp=CAU"],
                                ["mediaType":"","mediaPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHg9QPgX1Ugi49mFFsYcWSrsJhRjRYScGyjWLZZUl4UrSvu4MoGrCrWYqWgaiLYV9w5aA&usqp=CAU"],
                                ["mediaType":"","mediaPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAK92MyGos-U-fuF8VLWE530y7FuULP9yr4GCmJ_laIMvwX4HVa7XvcP8wo2BaIlpUtDI&usqp=CAU"],
                                ["mediaType":"","mediaPath":"https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg"],
                                ["mediaType":"","mediaPath":"https://t3.ftcdn.net/jpg/03/24/73/92/360_F_324739203_keeq8udvv0P2h1MLYJ0GLSlTBagoXS48.jpg"],
                                ["mediaType":"","mediaPath":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAK92MyGos-U-fuF8VLWE530y7FuULP9yr4GCmJ_laIMvwX4HVa7XvcP8wo2BaIlpUtDI&usqp=CAU"],
                                ["mediaType":"","mediaPath":"https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg"]],
                     
                     "menu":[
                        
                        ["menuCategoryId":1,"menuCategory":"Mombar","details":
                                [["photoPath":"https://radifarms.com/wp-content/uploads/2022/07/DSC_5629-scaled.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://radifarms.com/wp-content/uploads/2022/07/DSC_5629-scaled.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://radifarms.com/wp-content/uploads/2022/07/DSC_5629-scaled.jpg","price":3343.4,"title":"Test String","about":"About String"]]
                                ],
                        
                             ["menuCategoryId":1,"menuCategory":"Charcoal Grilled Chicken","details":
                                [["photoPath":"https://www.simplyrecipes.com/thmb/m1LB58rp40jNA5L7_6O3IJkj4Cc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Grilled-BBQ-Chicken-LEAD-10-03fd9892eaae4ce1a8a3f4c949657cfd.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://www.simplyrecipes.com/thmb/m1LB58rp40jNA5L7_6O3IJkj4Cc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Grilled-BBQ-Chicken-LEAD-10-03fd9892eaae4ce1a8a3f4c949657cfd.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://www.simplyrecipes.com/thmb/m1LB58rp40jNA5L7_6O3IJkj4Cc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Grilled-BBQ-Chicken-LEAD-10-03fd9892eaae4ce1a8a3f4c949657cfd.jpg","price":3343.4,"title":"Test String","about":"About String"]]
                                ],
                     
                             ["menuCategoryId":1,"menuCategory":"Stuffed Pigeon with Rice or Fereek","details":[["photoPath":"https://as1.ftcdn.net/v2/jpg/05/70/58/38/1000_F_570583820_jOIu0YGJQY8iZIVRWrsdVDPZ234EPFGX.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                ["photoPath":"https://as1.ftcdn.net/v2/jpg/05/70/58/38/1000_F_570583820_jOIu0YGJQY8iZIVRWrsdVDPZ234EPFGX.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                ["photoPath":"https://as1.ftcdn.net/v2/jpg/05/70/58/38/1000_F_570583820_jOIu0YGJQY8iZIVRWrsdVDPZ234EPFGX.jpg","price":3343.4,"title":"Test String","about":"About String"]]
                                ],
                     
                             ["menuCategoryId":1,"menuCategory":"Whole Charcoal Grilled Chicken","details":
                                [["photoPath":"https://homecookingmemories.com/wp-content/uploads/2012/07/Grilled-BBQ-Whole-Chicken-Butterflying-Spatchcocked-7.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://homecookingmemories.com/wp-content/uploads/2012/07/Grilled-BBQ-Whole-Chicken-Butterflying-Spatchcocked-7.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://homecookingmemories.com/wp-content/uploads/2012/07/Grilled-BBQ-Whole-Chicken-Butterflying-Spatchcocked-7.jpg","price":3343.4,"title":"Test String","about":"About String"]]
                                ],
        
        
                             ["menuCategoryId":1,"menuCategory":"Vine Leaves","details":
                                [["photoPath":"https://ichef.bbci.co.uk/food/ic/food_16x9_832/recipes/dolmades_72399_16x9.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://ichef.bbci.co.uk/food/ic/food_16x9_832/recipes/dolmades_72399_16x9.jpg","price":3343.4,"title":"Test String","about":"About String"]]
                                ],
        
                             ["menuCategoryId":1,"menuCategory":"Grilled Chicken Fillet","details":
                                [["photoPath":"https://assets.epicurious.com/photos/629e61c3c8fc75488633ba7d/1:1/w_4102,h_4102,c_limit/GrilledChickenBreast_RECIPE_052522_34925.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://assets.epicurious.com/photos/629e61c3c8fc75488633ba7d/1:1/w_4102,h_4102,c_limit/GrilledChickenBreast_RECIPE_052522_34925.jpg","price":3343.4,"title":"Test String","about":"About String"],
                                 ["photoPath":"https://assets.epicurious.com/photos/629e61c3c8fc75488633ba7d/1:1/w_4102,h_4102,c_limit/GrilledChickenBreast_RECIPE_052522_34925.jpg","price":3343.4,"title":"Test String","about":"About String"]]
                                ]
                        
                             ]] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.Details = PlaceDetails(dictionary: data)
            
            self.Dismiss.TextLabel = self.Details?.title ?? "Events"
            self.EventsName.text = self.Details?.title ?? "Events"
            
            self.TimeLabel.TextLabel = "\(self.Details?.openingHoursFrom ?? "") - \(self.Details?.openingHoursTo ?? "")"
            self.LocationLabel.TextLabel = self.Details?.areaName ?? ""
            self.DateLabel.TextLabel = self.Details?.startDate ?? ""
            self.AddCalendar.isEnabled = self.Details?.Schedule.count == 0 ? false:true
            self.Details?.isFavorite == true ? self.SavedButton.setImage(UIImage(named: "Saved"), for: .normal): self.SavedButton.setImage(UIImage(named: "NotSaved"), for: .normal)
            
            if self.Details?.rate != 0 {
                if let rate = self.Details?.rate {
                    self.ViewRating.isHidden = false
                    self.ViewRating.setTitle("lang".localizable == "ar" ? " \(rate) ".NumAR() : " \(rate) ", for: .normal)
                }else{
                    self.ViewRating.isHidden = true
                }
            }
            
            if let Gallery = self.Details?.Gallery {
                for item in Gallery {
                    SDWebImageManager.shared.loadImage(with: URL(string: item.mediaPath ?? ""), progress: nil) { image, _, error, _, _, _ in
                        if let Image = image {
                            self.imageArray.append(Image)
                            self.EventsCollection.reloadData()
                        }else{
                            self.imageArray.append(UIImage(named: "Group 26056") ?? UIImage())
                        }
                    }
                }
            }
            
            self.EventsTable.reloadData()
            self.IfNoData()
        }
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.IfNoData()
//    self.SetUpIsError(error, true) {self.SetDataEvents()}
//    }
    }
    
}

extension EventsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,MediaBrowserDelegate {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = imageArray.count
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventsId, for: indexPath) as! EventsCollectionCell
        cell.EventsImage.image = imageArray[indexPath.item]
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == EventsCollection {
        let pageWidth = Float(EventsCollection.frame.width)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(EventsCollection.contentSize.width)
        var newPage = Float(self.pageControl.currentPage)

        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.pageControl.set(progress: Int(newPage), animated: true)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    

    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
        return imageArray.count
    }
    
    func thumbnail(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    for image in imageArray {
    let Image = Media(image: image, caption: self.Details?.title ?? "Events")
    thumbs.append(Image)
    }
    return thumbs[index]
    }

    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    for image in imageArray {
    let Image = Media(image: image, caption: self.Details?.title ?? "Events")
    mediaArray.append(Image)
    }
    return mediaArray[index]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let browser = MediaBrowser(delegate: self)
    browser.setCurrentIndex(at: indexPath.item)
    browser.displayMediaNavigationArrows = true
    let nc = UINavigationController(rootViewController: browser)
    nc.modalPresentationStyle = .fullScreen
    nc.modalTransitionStyle = .coverVertical
    present(nc, animated: true)
    }
}
