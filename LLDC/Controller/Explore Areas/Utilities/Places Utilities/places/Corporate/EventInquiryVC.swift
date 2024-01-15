//
//  EventInquiryVC.swift
//  LLDC
//
//  Created by Emojiios on 03/04/2022.
//

import UIKit
import FlagPhoneNumber

class EventInquiryVC: ViewController ,FPNTextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Dismiss.TextLabel = "Event Inquiry".localizable
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15) , width: view.frame.width, height: view.frame.height - (Dismiss.frame.maxY + ControlY(15)))
        
        ViewScroll.addSubview(StackItems)
        StackItems.frame = CGRect(x: ControlX(15), y: 0, width: view.frame.width - ControlX(30), height: ViewScroll.frame.height)

        ViewScroll.updateContentViewSize(ControlX(30))
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        return Scroll
    }()

    lazy var NameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.text = getProfileObject().fullName
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var repository: FPNCountryRepository = FPNCountryRepository()
    lazy var PhoneNumberTF : FPNTextField = {
        let tf = FPNTextField()
        tf.displayMode = .list
        tf.delegate = self
        tf.text = getProfileObject().phone
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Phone Numbe".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    func SetUpPhoneNumber() {
    listController.setup(repository: PhoneNumberTF.countryRepository)
    listController.didSelect = { [weak self] country in
    self?.PhoneNumberTF.setFlag(countryCode: country.code)
    }
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
    print(name, dialCode, code)
    }
    
    var isValidNumber = true
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    isValidNumber = isValid
    }
    
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        listController.title = "Select your country".localizable
        listController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshCountries))
        listController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCountries))
        listController.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        listController.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        listController.searchController.searchBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        listController.searchController.searchBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        navigationViewController.modalPresentationStyle = .fullScreen
        navigationViewController.modalTransitionStyle = .coverVertical
        present(navigationViewController, animated: true)
    }
    
    @objc func refreshCountries() {
    listController.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc func dismissCountries() {
    listController.dismiss(animated: true, completion: nil)
    }
    
    lazy var EventNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Event name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    lazy var EventTypeTF : FloatingTF = {
        let tf = FloatingTF()
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Event type".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    var DateTime : DateOrTime?
    lazy var DateTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = .clear
        tf.ShowError = false
        tf.Icon.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.IconImage = UIImage(named: "calendar-2")
        tf.SetUpIcon(LeftOrRight: false, Width: 28, Height: 28)
        tf.addTarget(self, action: #selector(ActionDate), for: .editingDidBegin)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionDate), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionDate)))
        tf.attributedPlaceholder = NSAttributedString(string: "Date".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionDate() {
        DateTime = .Date
        ActionDateAndTime()
    }
    
    lazy var TimeTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = .clear
        tf.ShowError = false
        tf.Icon.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.IconImage = UIImage(named: "clock")
        tf.SetUpIcon(LeftOrRight: false, Width: 25, Height: 28)
        tf.addTarget(self, action: #selector(ActionTime), for: .editingDidBegin)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionTime), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionTime)))
        tf.attributedPlaceholder = NSAttributedString(string: "Time".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionTime() {
        DateTime = .Time
        ActionDateAndTime()
    }
    
    let DatePicker = UIDatePicker()
    @objc func ActionDateAndTime() {
        
        let PopUp = PopUpDownView()
        PopUp.currentState = .open
        PopUp.modalPresentationStyle = .overFullScreen
        PopUp.modalTransitionStyle = .coverVertical
        PopUp.endCardHeight = ControlWidth(240)
        PopUp.radius = 25

        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.text = DateTime == .Date ? "Date".localizable:"Time".localizable
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(20))
        PopUp.View.addSubview(Label)
        Label.frame = CGRect(x: ControlX(20), y: ControlY(15), width: PopUp.view.frame.width - ControlX(40), height: ControlWidth(30))
            
        DatePicker.minimumDate = Date()
        DatePicker.backgroundColor = .white
        DatePicker.datePickerMode = DateTime == .Date ? .date:.time
        DatePicker.locale = Locale(identifier: "lang".localizable)
        if #available(iOS 13.4, *) {DatePicker.preferredDatePickerStyle = .wheels} else {}
        
        DatePicker.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        DatePicker.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        DatePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        PopUp.View.addSubview(DatePicker)
        DatePicker.frame = CGRect(x: ControlX(20), y: Label.frame.maxY + ControlY(5), width: PopUp.view.frame.width - ControlX(40), height: ControlWidth(180))
        present(PopUp, animated: true)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
    if DateTime == .Date {
    DateTF.text = DatePicker.date.Formatter("yyyy/MM/dd")
    }else{
    TimeTF.text = DatePicker.date.Formatter("hh/mm a")
    }
    }

    lazy var NumberAttendeesTF : FloatingTF = {
        let tf = FloatingTF()
        tf.keyboardType = .numberPad
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Number of Attendees".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var NotesTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Notes (Optional)".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var WalletMessage : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Button.backgroundColor = .clear
        Button.titleLabel?.numberOfLines = 2
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.contentHorizontalAlignment = "lang".localizable == "ar" ? .right : .left
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(55)).isActive = true
        Button.setImage(UIImage(named: "circle")?.withInset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)), for: .normal)
        Button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        Button.setTitle("Please note our Team Will Contact you shortly to discuss the Event details.".localizable, for: .normal)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Light" ,size: ControlWidth(14))
        Button.backgroundColor = .clear
        return Button
    }()
   
    lazy var SubmitInquiry : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setTitle("Submit Inquiry".localizable, for: .normal)
        Button.addTarget(self, action: #selector(ActionSubmitInquiry), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionSubmitInquiry() {
    if NameTF.NoError() && PhoneNumberTF.NoError() && isValidNumber && EventNameTF.NoError() && EventTypeTF.NoError() && DateTF.NoError() && TimeTF.NoError() && NumberAttendeesTF.NoError()  {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    let api = "\(url + AddCorporateEvents)"
            
    guard let Name = NameTF.text else{return}
    guard let PhoneNumber = PhoneNumberTF.text else{return}
    guard let EventName = EventNameTF.text else{return}
    guard let EventType = EventTypeTF.text else{return}
    guard let NumberAttendeesTF = NumberAttendeesTF.text else{return}
    let DatePicker = DatePicker.date.Formatter("yyyy-MM-dd'T'HH:mm")
    let token = defaults.string(forKey: "jwt") ?? ""
    let SqlId = getProfileObject().sqlId ?? ""
    let Notes = NotesTF.text ?? ""
        
    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                   "Platform": "I",
                                   "SqlId": SqlId,
                                   "Lang": "lang".localizable,
                                   "name": Name,
                                   "phone": PhoneNumber,
                                   "eventName": EventName,
                                   "eventType": EventType,
                                   "eventDateTime": DatePicker,
                                   "numberOfAttendees": NumberAttendeesTF,
                                   "notes": Notes]
            
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.ViewDots.endRefreshing("Success Add Event".localizable, .success) {}
    self.NameTF.text = ""
    self.PhoneNumberTF.text = ""
    self.EventNameTF.text = ""
    self.EventTypeTF.text = ""
    self.DateTF.text = ""
    self.TimeTF.text = ""
    self.NotesTF.text = ""
    self.NumberAttendeesTF.text = ""
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { Error in
    self.ViewDots.endRefreshing(Error, .error) {}
    }
    }
    }
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [NameTF,PhoneNumberTF,EventNameTF,EventTypeTF,DateTF,TimeTF,NumberAttendeesTF,NotesTF,WalletMessage,UIView(),SubmitInquiry])
        Stack.axis = .vertical
        Stack.backgroundColor = .clear
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        return Stack
    }()
}
