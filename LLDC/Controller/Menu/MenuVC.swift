//
//  MenuVC.swift
//  LLDC
//
//  Created by Emojiios on 29/03/2022.
//

import UIKit
import FirebaseAuth

class MenuVC: ViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    let MenuId = "Menu"
    var MenuImage = ["Menu1","Menu2","Menu3","Menu4","Menu5","Menu6","Menu7","Menu9","Menu10"]
    var MenuArray = ["Become Platinum Member".localizable,"Update Password".localizable,
                     "Reservations".localizable,"Inquire for your event".localizable,
                     "Pending Reviews".localizable,"Language".localizable,"Saved".localizable,"Help".localizable,"Log Out".localizable]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        SetUpItems()
        MenuCollection.SetAnimations()
    }
    
    fileprivate func SetUpItems() {
        view.addSubview(ProfileView)
        ProfileView.frame = CGRect(x: 0, y: ControlY(40), width: view.frame.width, height: ControlWidth(50))
        
        view.addSubview(MenuCollection)
        MenuCollection.topAnchor.constraint(equalTo: ProfileView.bottomAnchor, constant: ControlY(10)).isActive = true
        MenuCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        MenuCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        MenuCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    lazy var ProfileView:ViewProfile = {
        let View = ViewProfile()
        View.backgroundColor = .clear
        View.ProfileView.text = "View Profile".localizable
        View.IconQR.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionQR)))
        View.ViewQR.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionQR)))
        View.LabelName.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionProfile)))
        View.ProfileView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionProfile)))
        View.LabelName.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionProfile)))
        View.ProfileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionProfile)))
        return View
    }()
    
    @objc func ActionProfile() {
    Present(ViewController: self, ToViewController: ProfileVC())
    }
    
    @objc func ActionQR() {
    Present(ViewController: self, ToViewController: ScanQRVC())
    }
        
    lazy var MenuCollection: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ControlX(15)
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(MenuCell.self, forCellWithReuseIdentifier: MenuId)
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(15), right: 0)
        return vc
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuId, for: indexPath) as! MenuCell

    cell.MenuLabel.text = MenuArray[indexPath.item]
    cell.ImageView.image = UIImage(named: MenuImage[indexPath.item])
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - ControlX(30), height: ControlWidth(70))
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
    Present(ViewController: self, ToViewController: BecomeMemberVC())
    case 1:
    Present(ViewController: self, ToViewController: ChangePasswordVC())
    case 2:
    Present(ViewController: self, ToViewController: ReservationsVC())
    case 3:
    Present(ViewController: self, ToViewController: EventInquiryVC())
    case 4:
    Present(ViewController: self, ToViewController: PendingReviewsVC())
    case 5:
    SetUpDownView()
    case 6:
    Present(ViewController: self, ToViewController: SavedVC())
//    case 7:
//    Present(ViewController: self, ToViewController: SettingsVC())
    case 7:
    Present(ViewController: self, ToViewController: HelpVC())
    case 8:
    ShowMessageAlert("Error", "Log Out".localizable, "Are You Sure You Want to log out of your account".localizable, false, self.ActionLogout , "Log Out".localizable)
    default: break}
    }
    
    @objc func GoToLogIn() {
    Present(ViewController: self, ToViewController: SignInController())
    }
    
    
    @objc func ActionLogout() {
        self.ViewDots.beginRefreshing()
        do {
        try Auth.auth().signOut()
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
        if key != "API" && key != "Url" && key != "WhatsApp" && key != "fireToken" && key != "jwt" {
        defaults.removeObject(forKey: key)}}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.ViewDots.endRefreshing() {
        FirstController(SignInController())
        }
        }

        }catch let signOutErr {
        self.ViewDots.endRefreshing(signOutErr.localizedDescription, .error) {}
        }
    }
    
    let PopUp = PopUpDownView()
    let PickerLanguage = UIPickerView()
    let Language = ["French".localizable,"Arabic".localizable,"Einglish".localizable]
    @objc func SetUpDownView() {
    PopUp.currentState = .open
    PopUp.modalPresentationStyle = .overFullScreen
    PopUp.modalTransitionStyle = .coverVertical
    PopUp.endCardHeight = ControlWidth(220)
    PopUp.radius = 25

    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    Label.textAlignment = .left
    Label.backgroundColor = .clear
    Label.text = "Close".localizable
    Label.isUserInteractionEnabled = true
    Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(20))
    Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DismissPopUp)))
        
    let Button = UIButton()
    Button.backgroundColor = .clear
    Button.setTitle("Save".localizable, for: .normal)
    Button.addTarget(self, action: #selector(DeviceLang), for: .touchUpInside)
    Button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(20))
    Button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)

    let Stack = UIStackView(arrangedSubviews: [Label,Button])
    Stack.axis = .horizontal
    Stack.spacing = ControlX(10)
    Stack.distribution = .equalSpacing
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    
    Stack.frame = CGRect(x: ControlX(20), y: ControlWidth(20), width: PopUp.view.frame.width - ControlX(40), height: ControlWidth(30))
    PopUp.View.addSubview(Stack)
        
    PickerLanguage.delegate = self
    PickerLanguage.backgroundColor = .clear
    PopUp.View.addSubview(PickerLanguage)
    PickerLanguage.frame = CGRect(x: ControlWidth(15), y: Stack.frame.maxY , width: PopUp.view.frame.width - ControlWidth(30), height: ControlWidth(170))
    switch "lang".localizable {
    case "fr":
    self.PickerLanguage.selectRow(0, inComponent: 0, animated: true)
    case "ar":
    self.PickerLanguage.selectRow(1, inComponent: 0, animated: true)
    case "en":
    self.PickerLanguage.selectRow(2, inComponent: 0, animated: true)
    default:
    break
    }
    present(PopUp, animated: true)
    }
    
    @objc func DismissPopUp() {
    PopUp.DismissAction()
    }

    @objc func DeviceLang() {
    if Lang == "lang".localizable || Lang == nil {
    PopUp.DismissAction()
    }else{
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    guard let version = getProfileObject().sqlId else{return}
    guard let lang = Lang else{return}

    let api = "\(url + AddDeviceLang)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""

    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                   "platform": "I",
                                   "lang": lang,
                                   "sqlId": version,
                                   "deviceId": udid]
    PopUp.DismissAction()
    ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.ActionLanguage()
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }
    }
    
    var Lang : String?
    @objc func ActionLanguage() {
    guard let lang = Lang else{return}
    if MOLHLanguage.currentAppleLanguage() != lang {
    MOLH.setLanguageTo(lang)
    self.ViewDots.endRefreshing() {MOLH.reset(duration: 0.5)}
    }
    }
    
}

extension MenuVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Language.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Language[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            Lang = "fr"
        case 1:
            Lang = "ar"
        case 2:
            Lang = "en"
        default:
        break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label:UILabel
        if let view = view as? UILabel {
            label = view
        }else{
            label = UILabel()
        }
        label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(16))
        label.text = Language[row]
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return ControlWidth(35)
    }
}


