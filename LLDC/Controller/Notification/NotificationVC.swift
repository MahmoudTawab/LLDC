//
//  NotificationVC.swift
//  LLDC
//
//  Created by Emojiios on 29/03/2022.
//

import UIKit

class NotificationVC: ViewController, UITableViewDelegate, UITableViewDataSource ,NotificationsDelegate ,SwipeTableViewCellDelegate {
    
    var NotificationsID = "Notifications"
    var NotificationsData = [Notifications]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUnread()
        SetUpItems()
        LodNotifications()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        view.addSubview(NotificationsLabel)
        NotificationsLabel.frame = CGRect(x: ControlX(15), y: ControlY(40), width: view.frame.width - ControlX(30), height: ControlWidth(60))
        
        view.addSubview(TableView)
        TableView.topAnchor.constraint(equalTo: NotificationsLabel.bottomAnchor, constant: ControlY(10)).isActive = true
        TableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        TableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        TableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: AppDelegate.PostNotification , object: nil)
    }
        
    lazy var NotificationsLabel : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        return Label
    }()
    
    func SetUnread() {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(10)

        let attributedString = NSMutableAttributedString(string: "Notifications".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Black", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        if IdUnread != 0 {
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        let Unread = "lang".localizable == "ar" ? "\(IdUnread)".NumAR() : "\(IdUnread)"
        attributedString.append(NSAttributedString(string: "\("You have".localizable) \(Unread) \("unread notifications".localizable)", attributes: [
            .font: UIFont(name: "SourceSansPro-Regular", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ,
            .paragraphStyle:style
        ]))
        }
        
        NotificationsLabel.attributedText = attributedString
    }

    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.indicatorStyle = .black
        tv.backgroundColor = .clear
        tv.alwaysBounceVertical = true
        tv.rowHeight = ControlWidth(90)
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        tv.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tv.addPullLoadableView(loadMoreView, type: .loadMore)
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(NotificationsCell.self, forCellReuseIdentifier: NotificationsID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(15), right: 0)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return NotificationsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsID, for: indexPath) as! NotificationsCell
        if indexPath.row == 0 {
        cell.ViewLine.isHidden = true
        }else{
        cell.ViewLine.isHidden = false
        }
        
        cell.Delegate = self
        cell.delegate = self
        
        cell.selectionStyle = .none
        cell.LabelTitle.setTitle(NotificationsData[indexPath.item].title, for: .normal)
        cell.LabelTitle.titleLabel?.addInterlineSpacing(spacingValue: ControlX(8))
        if let createdIn = NotificationsData[indexPath.item].createdIn?.Formatter() {
        cell.LabelDate.text = createdIn.timeAgo()
        }
        
        
        cell.ReadableView.backgroundColor = NotificationsData[indexPath.row].readable ?? true ? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) : #colorLiteral(red: 0.911247015, green: 0.5878974795, blue: 0.2701646686, alpha: 1)
        cell.backgroundColor = NotificationsData[indexPath.row].readable ?? true ? UIColor.clear : #colorLiteral(red: 0.8807458865, green: 0.8876826911, blue: 0.8516942405, alpha: 1)
        return cell
    }
    
    var SelectIndex = IndexPath()
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    if "lang".localizable == "ar" {
    guard orientation == .left else { return nil }
    }else{
    guard orientation == .right else { return nil }
    }
    let deleteAction = SwipeAction(style: .destructive, title: nil) { action, index in
        
    self.SelectIndex = indexPath
    ShowMessageAlert("Error", "Delete Notification".localizable, "Are You Sure You Want to Delete this Notifications".localizable, false, self.ActionDelete, "Delete".localizable)
    }

    deleteAction.image?.sd_tintedImage(with: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1))
    deleteAction.image = UIImage(named: "Group 26416")
    deleteAction.backgroundColor = NotificationsData[indexPath.row].readable ?? true ? #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1) : #colorLiteral(red: 0.8807458865, green: 0.8876826911, blue: 0.8516942405, alpha: 1)
    return [deleteAction]
    }
    
    func ActionDelete() {
    guard let id = NotificationsData[SelectIndex.row].id else{return}
    ReadableORDelete(Id:id,Read: false)
    }
    
    var defaultOptions = SwipeOptions()
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        if "lang".localizable == "ar" {
        options.expansionStyle = orientation == .left ? .selection : .destructive
        }else{
        options.expansionStyle = orientation == .right ? .selection : .destructive
        }
        options.transitionStyle = defaultOptions.transitionStyle
        options.backgroundColor = .white
        return options
    }

    func ActionView(cell: NotificationsCell) {
    if let index = TableView.indexPath(for: cell) {
    if let Details = NotificationsData[index.row].details ,let createdIn = NotificationsData[index.row].createdIn?.Formatter() ,let id = NotificationsData[index.row].id {
    if NotificationsData[index.row].readable == false {ReadableORDelete(Id:id,index:index, Read: true)}
    let Announcement = AnnouncementVC()
    Announcement.MessageText = Details
    Announcement.LabelDate.text = createdIn.timeAgo()
    Announcement.ReadableView.backgroundColor = NotificationsData[index.row].readable ?? true ? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) : #colorLiteral(red: 0.911247015, green: 0.5878974795, blue: 0.2701646686, alpha: 1)
    Announcement.modalPresentationStyle = .overFullScreen
    Announcement.modalTransitionStyle = .crossDissolve
    present(Announcement, animated: true)
    }
    }
    }
    
    
    func ReadableORDelete(Id:String,index:IndexPath = IndexPath(),Read:Bool) {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let Url = Read == true ? ReadNotification : DeleteNotification
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let api = "\(url + Url)"
//
//    let sqlId = getProfileObject().sqlId ?? ""
//    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                   "platform": "I",
//                                   "sqlId": sqlId,
//                                   "notId": Id]

    if !Read {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            if Read == true {
                self.IdUnread -= 1
                self.NotificationsData[index.row].readable = true
                self.TableView.reloadRows(at: [index], with: .automatic)
            }else{
                if self.NotificationsData[self.SelectIndex.row].readable == false {self.IdUnread -= 1}
                self.NotificationsData.remove(at: self.SelectIndex.row)
                self.TableView.beginUpdates()
                self.TableView.deleteRows(at: [IndexPath(row: self.SelectIndex.row, section: 0)], with: .right)
                self.TableView.endUpdates()
                self.IfNoData()
            }
            
            self.SetUnread()
        }
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if !Read {self.ViewDots.endRefreshing(error, .error) {}}else{}
//    }
    }
    
    var skip = 0
    var Animations = true
    var fetchingMore = false
    @objc func LodNotifications(removeAll:Bool = false, ShowDots:Bool = true) {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let sqlId = getProfileObject().sqlId ?? ""
//    let api = "\(url + GetNotification)"
//        
//
//    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                   "platform": "I",
//                                   "Lang": "lang".localizable,
//                                   "sqlId": sqlId,
//                                   "take": 15,
//                                   "skip": skip]
//        
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [
            ["id" : "","readable" : true,"iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title" : "String Title","details" : "String Details String Details String Details String Details String Details String Details","createdIn" : "2024-01-01T10:00:00"],
            ["id" : "","readable" : false,"iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title" : "String Title","details" : "String Details String Details String Details String Details String Details String Details","createdIn" : "2024-01-02T10:00:00"],
            ["id" : "","readable" : false,"iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title" : "String Title","details" : "String Details String Details String Details String Details String Details String Details","createdIn" : "2024-01-03T10:00:00"],
            ["id" : "","readable" : true,"iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title" : "String Title","details" : "String Details String Details String Details String Details String Details String Details","createdIn" : "2024-01-04T12:00:00"],
            ["id" : "","readable" : false,"iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title" : "String Title","details" : "String Details String Details String Details String Details String Details String Details","createdIn" : "2024-01-04T11:00:00"],
            ["id" : "","readable" : false,"iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title" : "String Title","details" : "String Details String Details String Details String Details String Details String Details","createdIn" : "2024-01-04T12:00:00"],
            ["id" : "","readable" : true,"iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title" : "String Title","details" : "String Details String Details String Details String Details String Details String Details","createdIn" : "2024-01-05T10:00:00"],
            ["id" : "","readable" : false,"iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title" : "String Title","details" : "String Details String Details String Details String Details String Details String Details","createdIn" : "2024-01-05T12:00:00"],
            ["id" : "","readable" : true,"iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title" : "String Title","details" : "String Details String Details String Details String Details String Details String Details","createdIn" : "2024-01-5T12:30:00"],
            ["id" : "","readable" : false,"iconPath" : "https://icon-library.com/images/star-icon-png/star-icon-png-0.jpg","title" : "String Title","details" : "String Details String Details String Details String Details String Details String Details","createdIn" : "2024-01-06T10:00:00"]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            if removeAll {
                self.TableView.RemoveAnimations {
                    self.IdUnread = 0
                    self.NotificationsData.removeAll()
                    self.Animations = true
                    self.AddData(dictionary:data)
                }
            }else{
                self.AddData(dictionary:data)
            }
        }
                        
//    } Err: { error in
//    if self.NotificationsData.count != 0 {
//    return
//    }else{
//    self.IfNoData()
//    self.SetUpIsError(error,true) {self.refresh()}
//    }
//    }
    }
    

    var IdUnread = Int()
    func AddData(dictionary:[[String:Any]]) {
    for item in dictionary {
    self.NotificationsData.append(Notifications(dictionary: item))
    self.skip += 1
    self.fetchingMore = false
    self.Animations == true ? self.TableView.SetAnimations() {self.Animations = false} : self.TableView.reloadData()
        
    if Notifications(dictionary: item).readable == false {
    IdUnread += 1
    SetUnread()
    }
    }
        
    self.IfNoData()
    }
    
    
    @objc func refresh() {
    skip = 0
    LodNotifications(removeAll: true)
    }
    
    func IfNoData() {
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    self.ViewNoData.isHidden = self.NotificationsData.count != 0 ? true : false
    self.TableView.isHidden = self.NotificationsData.count == 0 ? true : false
    self.ViewDots.endRefreshing(){}
    }
    
}

extension NotificationVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.LodNotifications(removeAll: false, ShowDots: false)
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
