//
//  BookConfirmationVC.swift
//  LLDC
//
//  Created by Emojiios on 04/04/2022.
//

import UIKit

class BookConfirmationVC: ViewController ,UITableViewDelegate , UITableViewDataSource ,ReservationsDetailsDelegate {

    var Reservation : ReservationsDetails?
    var BookButtonTitle = String()
    var reservationId : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        GetDataDetails()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Dismiss.TextLabel = "Book Confirmation".localizable
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
                
        view.addSubview(TableView)
        TableView.topAnchor.constraint(equalTo: Dismiss.bottomAnchor, constant: ControlY(10)).isActive = true
        TableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        TableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        TableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    let ReservationsId = "Reservations"
    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.alwaysBounceVertical = false
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        tv.register(BookConfirmationCell.self, forCellReuseIdentifier: ReservationsId)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReservationsId, for: indexPath) as! BookConfirmationCell
        cell.selectionStyle = .none
        
        cell.Delegate = self
        cell.ReservationData = Reservation
        cell.BackToHome.setTitle(BookButtonTitle, for: .normal)
        
        if BookButtonTitle == "Back to home".localizable  {
        cell.BackToHome.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        cell.BackToHome.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        }else{
        cell.BackToHome.backgroundColor = .clear
        cell.BackToHome.layer.borderColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        cell.BackToHome.layer.borderWidth = ControlX(1)
        cell.BackToHome.layer.cornerRadius = ControlX(10)
        cell.BackToHome.setTitleColor(#colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1), for: .normal)
        }
        return cell
    }
    
    var Reservations:ReservationsVC?
    func BackToHome(_ Cell: BookConfirmationCell) {
    if BookButtonTitle == "Back to home".localizable {
    FirstController(TabBarController())
    }else{
    if Reservation?.canCancel == true {
    ShowMessageAlert("Error", "Delete booking".localizable, "Are You Sure You Want to Delete this Booking".localizable, false, self.CanceAll,"Delete".localizable)
    }else{
    ShowMessageAlert("Error", "Error".localizable, "This reservation cannot be canceled".localizable, true, {})
    }
    }
    }
    
    func CanceAll() {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    guard let Id = reservationId else{return}

    let api = "\(url + CanceAllReservation)"
    let token = defaults.string(forKey: "jwt") ?? ""

    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                    "Platform": "I",
                                    "ReservationId": Id]
           
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.ViewDots.endRefreshing("Success".localizable + "Delete booking".localizable, .success) {
    self.Reservations?.refresh()
    self.navigationController?.popViewController(animated: true)
    }
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }
    
    let BookQr = BookConfirmationQr()
    func BackPeople(_ Cell:BookConfirmationCell,_ indexPath:IndexPath) {
    BookQr.ReservationData = Reservation
    BookQr.modalPresentationStyle = .overFullScreen
    BookQr.modalTransitionStyle = .crossDissolve
    BookQr.QrTitle = Reservation?.reservation[indexPath.item].fullName ?? ""
    BookQr.QrImage = Reservation?.reservation[indexPath.item].qrPath ?? ""
    BookQr.CancelIsHidden = BookButtonTitle != "Back to home".localizable ? false : true
    BookQr.CancelButton.addAction(for: .touchUpInside) { (button) in
    if self.Reservation?.canCancel == true {
    self.CancelReservation(Cell,indexPath)
    }else{
    ShowMessageAlert("Error", "Error".localizable, "This reservation cannot be canceled".localizable, true, {})
    }
    }
    present(BookQr, animated: true, completion: nil)
    }
    
    @objc func GetDataDetails() {
//    if Reservation == nil {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//        
//    guard let Id = reservationId else{return}
//    let sqlId = getProfileObject().sqlId ?? ""
//    let api = "\(url + GetReservationsDetails)"
//    let token = defaults.string(forKey: "jwt") ?? ""
//
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                    "Platform": "I",
//                                    "SqlId": sqlId,
//                                    "Lang": "lang".localizable,
//                                    "reservationId": Id]
       
 
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        let data = ["id" : "1", "coverPath" : "https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg","placeName" : "place Name String","areaName" : "Area Name String","date" : "23/10/1997","time" : "12:30 am","note" : "note String","canCancel" : true,"totalBookingFees" : 3.3,
                     "reservation":[["id" : "","profile" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK0EztGrrGWCA9CYjGkTmcQEmmqdDQaxLvQg&usqp=CAU","fullName" : "tawab hosny","qrPath" : "https://www.dontwasteyourtime.co.uk/wp-content/uploads/2011/11/Unitag-QR-Code-Resource-Page2-BITLY.png"],
                                
                        ["id" : "","profile" : "https://cdn2.steamgriddb.com/icon_thumb/798fa73dc39804b96742e2d3e6c5343a.png","fullName" : "Hosny Mahmoud","qrPath" : "https://www.dontwasteyourtime.co.uk/wp-content/uploads/2011/11/Unitag-QR-Code-Resource-Page2-BITLY.png"],
                                   
                        ["id" : "","profile" : "https://pics.craiyon.com/2023-07-01/c45e62641e1e42e1813ccbd239020726.webp","fullName" : "Ali hosny","qrPath" : "https://www.dontwasteyourtime.co.uk/wp-content/uploads/2011/11/Unitag-QR-Code-Resource-Page2-BITLY.png"]]] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.Reservation = ReservationsDetails(dictionary: data)
            self.IfNoData()
        }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.IfNoData()
//    self.ViewDots.endRefreshing(error, .error) {}
//    }
//    }
    }
    
    func IfNoData() {
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(GetDataDetails), for: .touchUpInside)
    self.TableView.isHidden = self.Reservation == nil ? true : false
    self.ViewNoData.isHidden = self.Reservation != nil ? true : false
    self.TableView.SetAnimations()
    self.ViewDots.endRefreshing(){}
    }
    
 
    @objc func CancelReservation(_ Cell:BookConfirmationCell,_ indexPath:IndexPath) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    guard let Id = Reservation?.reservation[indexPath.item].id else{return}
        
    let api = "\(url + CanceReservation)"
    let token = defaults.string(forKey: "jwt") ?? ""

    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                    "Platform": "I",
                                    "Id": Id]

    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.Reservation?.reservation.remove(at: indexPath.item)
    Cell.PeopleCollection.deleteItems(at: [indexPath])
    if self.Reservation?.reservation.count == 0 {
    self.CanceAll()
    }else{
    self.BookQr.dismiss(animated: true)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    self.ViewDots.endRefreshing("Success".localizable + " " + "Delete".localizable, .success) {}
    }
    }
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }
    
}

