//
//  SignUpController.swift
//  LLDC
//
//  Created by Emojiios on 29/03/2022.
//

import UIKit
import FlagPhoneNumber

class SignUpController: ViewController ,FPNTextFieldDelegate {

    var CityId : Int?
    var MarketingId : Int?
    var InfoSignUp : SignUpInfo?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        SetUpItems()
    }
        
    fileprivate func SetUpItems() {
        ViewScroll.frame = CGRect(x: 0, y: -TopHeight, width: view.frame.width, height: view.frame.height + TopHeight)
        view.addSubview(ViewScroll)

        ViewScroll.addSubview(ImageLogo)
        ImageLogo.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ControlHeight(210))

        ViewScroll.addSubview(StackItems)
        StackItems.frame = CGRect(x: ControlX(30), y: ImageLogo.frame.maxY + ControlY(20), width: view.frame.width - ControlX(60), height: ControlHeight(960))
        
        ViewScroll.addSubview(FamilyMembers)
        FamilyMembers.translatesAutoresizingMaskIntoConstraints = false
        FamilyMembers.bottomAnchor.constraint(equalTo: StackItems.arrangedSubviews[13].bottomAnchor,constant: ControlX(-10)).isActive = true
        FamilyMembers.trailingAnchor.constraint(equalTo: StackItems.trailingAnchor).isActive = true
        FamilyMembers.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        FamilyMembers.widthAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true

        ViewScroll.updateContentViewSize(ControlX(20))
        SetUpPhoneNumber()
        SetSignUpScreenInfo()
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.bounces = false
        Scroll.isHidden = true
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()

    lazy var ImageLogo : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleToFill
        ImageView.image = UIImage(named: "Group 57532")
        return ImageView
    }()

    lazy var SignUpLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(5)
        
        let attributedString = NSMutableAttributedString(string: "Bonjour!".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Black", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.3291127384, green: 0.3332326412, blue: 0.3417333364, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "Apply for membership".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Black", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(55)).isActive = true
        return Label
    }()
    
    lazy var FullName : FloatingTF = {
        let tf = FloatingTF()
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Full name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsEmail
        tf.keyboardType = .emailAddress
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Email".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
  
    lazy var PasswordTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsPassword
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.IconImage = UIImage(named: "visibility-1")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionPassword), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Password".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionPassword() {
        if PasswordTF.IconImage == UIImage(named: "visibility-1") {
            PasswordTF.isSecureTextEntry = false
            PasswordTF.IconImage = UIImage(named: "visibility")
        }else{
            PasswordTF.isSecureTextEntry = true
            PasswordTF.IconImage = UIImage(named: "visibility-1")
        }
    }
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var repository: FPNCountryRepository = FPNCountryRepository()
    lazy var PhoneNumberTF : FPNTextField = {
        let tf = FPNTextField()
        tf.displayMode = .list
        tf.delegate = self
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
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
    
    var isValidNumber = false
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
    
    lazy var GenderTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.IconImage = UIImage(named: "Path")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionGender), for: .touchUpInside)
        tf.addTarget(self, action: #selector(ActionGender), for: .editingDidBegin)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionGender)))
        tf.attributedPlaceholder = NSAttributedString(string: "Gender".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionGender() {
    let title = "Gender".localizable
    let attributeString = NSMutableAttributedString(string: title)
        attributeString.addAttributes([NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)],//3
                                                  range: NSMakeRange(0, title.count))
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    alertController.setValue(attributeString, forKey: "attributedTitle")
    alertController.addAction(UIAlertAction(title: "Male".localizable, style: .default , handler: { (_) in
    self.GenderTF.text = "Male".localizable
    }))
 

    alertController.addAction(UIAlertAction(title: "FeMale".localizable, style: .default , handler: { (_) in
    self.GenderTF.text = "FeMale".localizable
    }))
        
    alertController.view.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
    present(alertController, animated: true)
    }
    
    lazy var BirthdayTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = .clear
        tf.Icon.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        tf.IconImage = UIImage(named: "calendar")
        tf.SetUpIcon(LeftOrRight: true, Width: 25, Height: 27)
        tf.addTarget(self, action: #selector(ActionBirthday), for: .editingDidBegin)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionBirthday), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionBirthday)))
        tf.attributedPlaceholder = NSAttributedString(string: "Birthday".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    let DatePicker = UIDatePicker()
    @objc func ActionBirthday() {
        
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
        Label.text = "Birthday".localizable
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(20))
        PopUp.View.addSubview(Label)
        Label.frame = CGRect(x: ControlX(20), y: ControlY(15), width: PopUp.view.frame.width - ControlX(40), height: ControlWidth(30))
            
        DatePicker.maximumDate = Date()
        DatePicker.datePickerMode = .date
        DatePicker.backgroundColor = .white
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
    BirthdayTF.text = DatePicker.date.Formatter("yyyy-MM-dd")
    }


    var CityAreas : CitiesOrAreas?
    lazy var CityTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = .clear
        tf.IconImage = UIImage(named: "City")
        tf.SetUpIcon(LeftOrRight: true, Width: 26, Height: 28)
        tf.addTarget(self, action: #selector(ActionCity), for: .editingDidBegin)
        tf.Icon.addTarget(self, action: #selector(ActionCity), for: .touchUpInside)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionCity)))
        tf.attributedPlaceholder = NSAttributedString(string: "City".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionCity() {
        CityAreas = .City
        SetUpDownView("City".localizable)
    }

    lazy var HomeAddressTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.Icon.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        tf.IconImage = UIImage(named: "Location")
        tf.SetUpIcon(LeftOrRight: true, Width: 22, Height: 26)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionHomeAddress), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Home Address".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionHomeAddress() {
//    let myAddress = "One,Apple+Park+Way,Cupertino,CA,95014,USA"
//    let geoCoder = CLGeocoder()
//    geoCoder.geocodeAddressString(myAddress) { (placemarks, error) in
//    guard let placemarks = placemarks?.first else { return }
//    let location = placemarks.location?.coordinate ?? CLLocationCoordinate2D()
//    guard let url = URL(string:"http://maps.apple.com/?daddr=\(location.latitude),\(location.longitude)") else { return }
//    UIApplication.shared.open(url)
//    }
    }


    lazy var HowDidKnowTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.ShowError = false
        tf.IconImage = UIImage(named: "Path")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        tf.addTarget(self, action: #selector(ActionHowDidKnow), for: .editingDidBegin)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionHowDidKnow), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionHowDidKnow)))
        tf.attributedPlaceholder = NSAttributedString(string: "How did you know us?".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionHowDidKnow() {
        CityAreas = .HowDidKnow
        SetUpDownView("How did you know us?".localizable)
    }
    
    let PickerCitiesAreas = UIPickerView()
    @objc func SetUpDownView(_ text:String) {
    let PopUp = PopUpDownView()
    PopUp.currentState = .open
    PopUp.modalPresentationStyle = .overFullScreen
    PopUp.modalTransitionStyle = .coverVertical
    PopUp.endCardHeight = ControlWidth(240)
    PopUp.radius = 25

    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    Label.text = text
    Label.textAlignment = .center
    Label.backgroundColor = .clear
    Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(20))
    PopUp.View.addSubview(Label)
    Label.frame = CGRect(x: ControlWidth(15), y: ControlWidth(15), width: PopUp.view.frame.width - ControlWidth(30), height: ControlWidth(30))
        
    PickerCitiesAreas.delegate = self
    PickerCitiesAreas.backgroundColor = .clear
    PopUp.View.addSubview(PickerCitiesAreas)
    PickerCitiesAreas.frame = CGRect(x: ControlWidth(15), y: Label.frame.maxY + ControlX(5), width: PopUp.view.frame.width - ControlWidth(30), height: ControlWidth(180))
    present(PopUp, animated: true)
    }
    

    lazy var LinkedInTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.IconImage = UIImage(named: "Linkedin")
        tf.SetUpIcon(LeftOrRight: true, Width: 26, Height: 28)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionLinkedIn), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Linked in".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionLinkedIn() {
        guard let url = URL(string: "https://linkedin.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
        }
    }
    
    lazy var FacebookTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.IconImage = UIImage(named: "facebook")
        tf.SetUpIcon(LeftOrRight: true, Width: 26, Height: 28)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionFacebook), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Facebook".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionFacebook() {
        guard let url = URL(string: "https://de-de.facebook.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
        }
    }

    lazy var InstagramTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.IconImage = UIImage(named: "instagram")
        tf.SetUpIcon(LeftOrRight: true, Width: 26, Height: 28)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionInstagram), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Instagram".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionInstagram() {
        guard let url = URL(string: "https://instagram.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
        }
    }

    
    lazy var FamilyMembersTF : FloatingTF = {
        let tf = FloatingTF()
        tf.isEnabled = false
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "FamilyMembers".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var FamilyMembers:GMStepper = {
        let View = GMStepper()
        View.borderWidth = 0
        View.minimumValue = 1
        View.label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        View.buttonsTextColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        View.labelBackgroundColor = .white
        View.label.backgroundColor = .clear
        View.limitHitAnimationColor = .clear
        View.buttonsBackgroundColor = .clear
        View.leftButton.layer.borderColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        View.rightButton.layer.borderColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        View.leftButton.layer.borderWidth = ControlWidth(1)
        View.rightButton.layer.borderWidth = ControlWidth(1)
        View.leftButton.layer.cornerRadius = ControlX(8)
        View.rightButton.layer.cornerRadius = ControlX(8)
        View.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        View.labelFont = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15))
        return View
    }()

    
    @objc func stepperValueChanged() {
    FamilyMembersTF.attributedPlaceholder = NSAttributedString(string: "\("FamilyMembers".localizable) \("lang".localizable == "ar" ? String(Int(FamilyMembers.value)).NumAR() : String(Int(FamilyMembers.value)))", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
    }
    

    lazy var CheckboxButton : Checkbox = {
        let Button = Checkbox(type: .system)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        
        let underlinedMessage = NSMutableAttributedString(string: "I read and agree to the Terms and Conditions".localizable, attributes: [.foregroundColor: #colorLiteral(red: 0.7036916041, green: 0.7036916041, blue: 0.7036916041, alpha: 1) ,
                                                        .font:UIFont(name: "SourceSansPro-Regular", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
                                                        .underlineStyle:NSUnderlineStyle.single.rawValue])
        
        Button.Label.attributedText = underlinedMessage
        Button.Label.backgroundColor = .clear
        return Button
    }()
    
    lazy var SignUp : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Sign Up".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSignUp), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionSignUp() {
    if FullName.NoError() && EmailTF.NoError() && PasswordTF.NoError() && PasswordTF.NoErrorPassword() && EmailTF.NoErrorEmail() && PhoneNumberTF.NoError() && isValidNumber && CityTF.NoError() && BirthdayTF.NoError() && GenderTF.NoError() {
    if CheckboxButton.Button.tag != 1 {
    CheckboxButton.Shake()
    }else{
    CheckUserIsError()
    }
    }
    }
    
    var MainData : Main?
    func CheckUserIsError() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//        
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let api = "\(url + CheckMember)"
//                  
//    guard let Email = EmailTF.text else{return}
//    guard let Phone = PhoneNumberTF.text else{return}
//                    
//    ViewDots.beginRefreshing()
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                   "Platform": "I",
//                                   "Email": Email,
//                                   "Phone": Phone]
//        
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
//    self.MainData = Main(dictionary: data)
//
//    if self.MainData?.emailUsed == true {
//    self.EmailTF.Shake()
//    self.EmailTF.becomeFirstResponder()
//    ShowMessageAlert("Error", "Error".localizable , "Email is already in use", true, {})
//        
//    }else if self.MainData?.phoneUsed == true {
//    self.PhoneNumberTF.Shake()
//    self.PhoneNumberTF.becomeFirstResponder()
//    ShowMessageAlert("Error", "Error".localizable , "Phone is already in use", true, {})
//        
//    }else{
    let OTP = OTPController()
    OTP.SignUp = self
    Present(ViewController: self, ToViewController: OTP)
//    }
//      
//    self.ViewDots.endRefreshing {}
//    } ArrayOfDictionary: { _ in
//    } Err: { Err in
//    self.ViewDots.endRefreshing(Err, .error, {})
//    }
    }
    

    lazy var SignInLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(5)
        style.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: "Already have an account".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Light", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "Sign In".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1) ,
            .paragraphStyle:style,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]))
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "to your account here".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Light", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.attributedText = attributedString

        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionSignIn)))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(55)).isActive = true
        return Label
    }()
    
    @objc func ActionSignIn() {
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [SignUpLabel,FullName,EmailTF,PasswordTF, PhoneNumberTF,GenderTF,BirthdayTF,CityTF,HomeAddressTF,HowDidKnowTF,LinkedInTF,FacebookTF,InstagramTF,FamilyMembersTF,CheckboxButton,SignUp,SignInLabel])
        Stack.axis = .vertical
        Stack.backgroundColor = .clear
        Stack.spacing = ControlX(10)
        Stack.distribution = .equalSpacing
        return Stack
    }()

}

public enum CitiesOrAreas {
    case City,HowDidKnow
}

extension SignUpController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CityAreas == .City ? InfoSignUp?.city.count ?? 0 : InfoSignUp?.Marketing.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CityAreas == .City ? InfoSignUp?.city[row].name : InfoSignUp?.Marketing[row].Channel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if CityAreas == .City {
        CityId = InfoSignUp?.city[row].id
        CityTF.text = InfoSignUp?.city[row].name
        }else{
        MarketingId = InfoSignUp?.Marketing[row].id
        HowDidKnowTF.text = InfoSignUp?.Marketing[row].Channel
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
        label.text = CityAreas == .City ? InfoSignUp?.city[row].name : InfoSignUp?.Marketing[row].Channel
        return label
    }
    

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return ControlWidth(35)
    }
    
    func SetSignUpScreenInfo() {
//    guard let token = defaults.string(forKey: "jwt") else{
//    self.SetUpIsError("InternetNotAvailable".localizable, true, self.SetSignUpScreenInfo)
//    return
//    }
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let api = "\(url + SignUpScreenInfo)"
//    let parameters:[String : Any] = ["lang": "lang".localizable]
//    
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in

        
        
        let data = ["city":[["id" : 1,"name" : "Cairo"],
                             ["id" : 2,"name" : "Alexandria"],
                             ["id" : 3,"name" : "Giza"],
                             ["id" : 4,"name" : "Shubra El Kheima"],
                             ["id" : 5,"name" : "Ismaïlia"],
                             ["id" : 6,"name" : "Aswān"]]
                     ,"marketingChannel":
                     [["id" : 1,"channel" : "Linked"],
                     ["id" : 2,"channel" : "instagram"],
                     ["id" : 3,"channel" : "Network"],
                     ["id" : 4,"channel" : "Facebook"],
                     ["id" : 5,"channel" : " youtube"]]
        ] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.InfoSignUp = SignUpInfo(dictionary: data)
            self.PickerCitiesAreas.reloadAllComponents()
            self.ViewDots.endRefreshing() {}
            
            self.ViewScroll.isHidden = false
            self.ViewNoData.isHidden = true
        }
//    } ArrayOfDictionary: { _ in
//    } Err: { (error) in
//    self.ViewScroll.isHidden = true
//    self.SetUpIsError(error, true, self.SetSignUpScreenInfo)
//    }
    }
}


