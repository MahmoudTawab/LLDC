//
//  InviteGuestsVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/07/2021.
//

import UIKit
import ContactsUI

struct Contacts {
var Numbers:String
var Names:String
var email:String
var Image:UIImage
var Id : String?
}

class InviteGuestsVC: ViewController ,CNContactPickerDelegate, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,InviteGuestsDelegate {
    
    var IdSelect = [String]()
    var objects  = [Contacts]()
    var filtered = [Contacts]()
    private let InviteGuestsID = "CellInviteGuests"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        
        SetUpItems()
        getContacts()
        CollectionView.SetAnimations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,object: nil, queue: OperationQueue.main,using: keyboardWillShowNotification)
        
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,object: nil, queue: OperationQueue.main,
        using: keyboardWillHideNotification)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func getContacts() {
    let store = CNContactStore()
    switch CNContactStore.authorizationStatus(for: .contacts) {
    case .authorized:
    self.retrieveContactsWithStore(store: store)
    case .notDetermined:
    store.requestAccess(for: .contacts){succeeded, err in
    guard err == nil && succeeded else{return}
    self.retrieveContactsWithStore(store: store)
    }default:
    print("Not handled")
    }
    }
    
    func retrieveContactsWithStore(store: CNContactStore) {
    let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey,CNContactImageDataKey, CNContactEmailAddressesKey] as [Any]
    let request = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
    do {
    let formatter = CNContactFormatter()
    try store.enumerateContacts(with: request){ (contact, cursor) -> Void in
    for phone in contact.phoneNumbers {
    if formatter.string(from: contact) != nil && phone.value.stringValue != "" && phone.value.stringValue.count > 11 {
        
    let imageData = contact.imageData ?? Data()
    let email = (contact.emailAddresses.first?.value ?? " ") as String
    let Number = phone.value.stringValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
    self.objects.append(Contacts(Numbers: Number, Names: formatter.string(from: contact) ?? " ", email: email, Image: UIImage(data: imageData) ?? UIImage(named: "Profile") ?? UIImage(), Id: "\(contact.identifier):\(phone.value.stringValue)"))
        
    self.filtered.append(Contacts(Numbers: Number, Names: formatter.string(from: contact) ?? " ", email: email, Image: UIImage(data: imageData) ?? UIImage(named: "Profile") ?? UIImage() , Id: "\(contact.identifier):\(phone.value.stringValue)"))

    for item in self.IdSelect {
    self.filtered.sort { contact, contact in
    contact.Id == item
    }
    }
        
    }
    }
    }
    } catch let error {
    NSLog("Fetch contact error: \(error)")
    }
    DispatchQueue.main.async {
    self.CollectionView.reloadData()
    }
    }
    
    func keyboardWillShowNotification(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        EdgeInsets(top: 0, bottom: keyboardSize.height + 10)
    }
    
    func keyboardWillHideNotification(notification: Notification) {
    EdgeInsets(top: 0, bottom: 10)
    }
    
    fileprivate func SetUpItems() {
    
    view.addSubview(Dismiss)
    Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.TextLabel = "Contacts".localizable
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(100), height: ControlWidth(40))
    
    view.addSubview(NextButton)
    NextButton.translatesAutoresizingMaskIntoConstraints = false
    NextButton.heightAnchor.constraint(equalToConstant: ControlWidth(38)).isActive = true
    NextButton.widthAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
    NextButton.topAnchor.constraint(equalTo: view.topAnchor,constant: ControlY(40)).isActive = true
    NextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant:  ControlX(-10)).isActive = true
     
    view.addSubview(SearchTextField)
    SearchTextField.translatesAutoresizingMaskIntoConstraints = false
    SearchTextField.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
    SearchTextField.topAnchor.constraint(equalTo: NextButton.bottomAnchor, constant: ControlX(10)).isActive = true
    SearchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
    SearchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant:  ControlX(-15)).isActive = true
    SearchTextField.layer.cornerRadius = ControlWidth(20)
            
    view.addSubview(SearchIcon)
    SearchIcon.translatesAutoresizingMaskIntoConstraints = false
    SearchIcon.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    SearchIcon.widthAnchor.constraint(equalTo: SearchIcon.heightAnchor).isActive = true
    SearchIcon.centerYAnchor.constraint(equalTo: SearchTextField.centerYAnchor).isActive = true
    SearchIcon.trailingAnchor.constraint(equalTo: SearchTextField.trailingAnchor , constant:  ControlX(-10)).isActive = true
        
    view.addSubview(CollectionView)
    CollectionView.topAnchor.constraint(equalTo: SearchTextField.bottomAnchor, constant: ControlY(10)).isActive = true
    CollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    CollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    CollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    EdgeInsets(top: 0, bottom: ControlX(20))
    }


    lazy var NextButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.backgroundColor = .clear
        Button.setTitle("Next".localizable, for: .normal)
        Button.addTarget(self, action: #selector(ActionNext), for: .touchUpInside)
        Button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(18))
        Button.setTitleColor(#colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1), for: .normal)
        return Button
    }()
    
    
    @objc func ActionNext() {
    let InviteSelected = InviteGuestsSelected()
    InviteSelected.InviteGuests = self
        
    InviteGuestsSelected.Image.removeAll()
    InviteGuestsSelected.IdSelect.removeAll()
    InviteGuestsSelected.Guests.removeAll()
        
    if IdSelect.count != 0 {
    for item in IdSelect {
    let Select = objects.filter{($0.Id == item)}
     
    Select.forEach { User in
    if let Id = User.Id {
    InviteGuestsSelected.IdSelect.append(Id)
    InviteGuestsSelected.Image.append(User.Image)
    InviteGuestsSelected.Guests.append(GuestsSelected(email1: User.email, fName: User.Names, phoneNumber1: User.Numbers))
    }
    }
    
    if InviteGuestsSelected.IdSelect.count == Select.count {
    Present(ViewController: self, ToViewController: InviteSelected)
    }
    }
    }else{
    self.navigationController?.popViewController(animated: true)
    }
    }
    
    lazy var SearchTextField : UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .clear
        tf.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.clearButtonMode = .never
        tf.autocorrectionType = .no
        tf.keyboardAppearance = .light
        tf.layer.borderColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1).cgColor
        tf.layer.borderWidth = ControlWidth(2)
        tf.attributedPlaceholder = NSAttributedString(string: "Search".localizable,
        attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(15) , height: tf.frame.height))
        tf.leftViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(50), height: tf.frame.height))
        tf.rightViewMode = .always
        tf.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(16))
        tf.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
        return tf
    }()
    
    lazy var SearchIcon : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Button.backgroundColor = .clear
        Button.setBackgroundImage(UIImage(named: "plus_icn_pink"), for: .normal)
        Button.addTarget(self, action: #selector(ActionSearchIcon), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSearchIcon() {
    SearchTextField.text = ""
    }
    
    lazy var CollectionView: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(InviteGuestsCell.self, forCellWithReuseIdentifier: InviteGuestsID)
        return vc
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InviteGuestsID, for: indexPath) as! InviteGuestsCell
        cell.backgroundColor = .clear
        cell.Delegate = self
            
        let contact = self.filtered[indexPath.row]
        let Phone = String(contact.Numbers.enumerated().map { $0 > 0 && $0 % 4 == 0 ? [" ",$1] : [$1]}.joined())
            
        cell.PhoneLabel.text = Phone
        cell.NameLabel.text = contact.Names
        cell.ProfileImage.image = contact.Image
        cell.IdCell = contact.Id
            
        if let Id = contact.Id {
        if self.IdSelect.contains(Id) {
        cell.SelectButton.setBackgroundImage(UIImage(named: "InviteSelect"), for: .normal)
        }else{
        cell.SelectButton.setBackgroundImage(UIImage(named: "AddNoSelect"), for: .normal)
        }
        }
            
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: ControlWidth(80))
    }
    
    func ActionSelectImage(Cell:InviteGuestsCell) {
        
        if let indexPath = CollectionView.indexPath(for: Cell) {
        guard let Id = Cell.IdCell else {return}
        if self.IdSelect.contains(Id) {
        if let index = self.IdSelect.firstIndex(of: Id) {
        IdSelect.remove(at: index)
        CollectionView.reloadItems(at: [indexPath])
        }
        }else{
        if self.IdSelect.count < 4 {
        IdSelect.append(Id)
        CollectionView.reloadItems(at: [indexPath])
        }else{
        ShowMessageAlert("Error", "Error".localizable, "It is not possible to add an invitation to more than four guests".localizable, true, {})
        }
        }
        
        UIView.animate(withDuration: 0.3, animations: {
        Cell.SelectButton.transform = Cell.SelectButton.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
        UIView.animate(withDuration: 0.3, animations: {
        Cell.SelectButton.transform = .identity
        })
        })
        }
    }
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
    if textfield.text == "" {
    self.filtered = self.objects
    } else {
    self.filtered = self.objects.filter { Text in
    if let text = textfield.text?.lowercased() {
    return Text.Names.lowercased().contains(text) || Text.Numbers.lowercased().contains(text)
    }else {
    return false
    }
    }
    }

    CollectionView.reloadData()
    }
    
    func EdgeInsets(top:CGFloat,bottom:CGFloat) {
        let contentInsets = UIEdgeInsets(top: top, left: 0.0, bottom: bottom, right: 0.0)
        CollectionView.contentInset = contentInsets
        CollectionView.scrollIndicatorInsets = contentInsets
    }
}
