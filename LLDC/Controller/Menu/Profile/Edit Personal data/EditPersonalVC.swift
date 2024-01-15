//
//  EditPersonalVC.swift
//  LLDC
//
//  Created by Emojiios on 30/03/2022.
//

import UIKit
import SDWebImage
import FlagPhoneNumber

class EditPersonalVC: ViewController ,FPNTextFieldDelegate , MediaBrowserDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    var cityId : Int?
    var Profile :ProfileVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        
    view.addSubview(Dismiss)
    Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.TextLabel = "Edit Personal data".localizable
    Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(40), width: view.frame.width - ControlX(30), height: ControlWidth(40))
       
    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(20), width: view.frame.width, height: view.frame.height - ControlWidth(70))
        
    ViewScroll.addSubview(ProfileImage)
    ProfileImage.frame = CGRect(x: ViewScroll.center.x - ControlWidth(60), y: 0, width: ControlWidth(120), height: ControlWidth(120))
        
    ViewScroll.addSubview(ImageEdit)
    ImageEdit.frame = CGRect(x: ProfileImage.frame.maxX - ControlWidth(40), y: ProfileImage.frame.maxY - ControlWidth(35), width: ControlWidth(40), height: ControlWidth(40))
    ImageEdit.layer.cornerRadius = ControlX(20)
        
    ViewScroll.addSubview(StackItems)
    StackItems.frame = CGRect(x: ControlX(20), y: ProfileImage.frame.maxY + ControlX(30), width: view.frame.width - ControlX(40), height: ControlWidth(640))
        
    ViewScroll.updateContentViewSize(ControlX(70))
    SetUpPhoneNumber()
    SetCity()
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.isHidden = true
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()

    lazy var ProfileImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ImageView.backgroundColor = .clear
        ImageView.layer.masksToBounds = true
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.borderWidth = ControlWidth(2)
        ImageView.layer.cornerRadius = ControlX(60)
        ImageView.isUserInteractionEnabled = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DidSelect)))
        ImageView.sd_setImage(with: URL(string: getProfileObject().profileImg ?? ""), placeholderImage: UIImage(named: "Profile"))
        return ImageView
    }()
    
    @objc func DidSelect() {
        if ProfileImage.image != UIImage(named: "Profile") {
        let browser = MediaBrowser(delegate: self)
        browser.enableGrid = false
        browser.title = "Profile Image".localizable
        let nc = UINavigationController(rootViewController: browser)
        nc.modalPresentationStyle = .fullScreen
        nc.modalTransitionStyle = .coverVertical
        present(nc, animated: true)
        }
    }
    
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
        return 1
    }
    
    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    let photo = Media(image: ProfileImage.image ?? UIImage())
    return photo
    }

    lazy var ImageEdit : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = .white
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.layer.shadowRadius = 4
        Button.layer.shadowOpacity = 0.2
        Button.layer.shadowOffset = .zero
        Button.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor
        Button.setImage(UIImage(named: "edit"), for: .normal)
        Button.addTarget(self, action: #selector(ActionImage), for: .touchUpInside)
        return Button
    }()

    @objc func ActionImage() {
    let ImagePickerController = UIImagePickerController()
    ImagePickerController.allowsEditing = true
    ImagePickerController.delegate = self
    let Style = UIDevice.current.userInterfaceIdiom == .phone ? UIAlertController.Style.actionSheet:UIAlertController.Style.alert
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: Style)
    alertController.addAction(UIAlertAction(title: "Camera".localizable, style: .default, handler: { (action:UIAlertAction) in
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
    ImagePickerController.sourceType = .camera
    ImagePickerController.modalPresentationStyle = .fullScreen
    self.present(ImagePickerController, animated: true , completion: nil)
    }else{print("Camera not available")}
    }))
    alertController.addAction(UIAlertAction(title: "Photo Library".localizable, style: .default, handler: { (action:UIAlertAction) in
    ImagePickerController.sourceType = .photoLibrary
    ImagePickerController.modalPresentationStyle = .fullScreen
    self.present(ImagePickerController, animated: true , completion: nil)
    }))
    alertController.view.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
    alertController.addAction(UIAlertAction(title: "Cancel".localizable, style: .cancel, handler: nil))
    alertController.modalPresentationStyle = .fullScreen
    self.present(alertController, animated: true , completion: nil)
    }
    
    var imageIsChanges = false
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage
        ProfileImage.image = image
        imageIsChanges = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
    

    lazy var FullName : FloatingTF = {
        let tf = FloatingTF()
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Full name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.alpha = 0.6
        tf.isEnabled = false
        tf.Enum = .IsEmail
        tf.keyboardType = .emailAddress
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Email".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
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
    
    lazy var GenderTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.ShowError = false
        tf.Icon.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
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
        tf.Icon.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tf.IconImage = UIImage(named: "calendar")
        tf.SetUpIcon(LeftOrRight: false, Width: 25, Height: 27)
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
    BirthdayTF.text = DatePicker.date.Formatter("yyyy/MM/dd")
    }


    var CityData = [City]()
    var CityAreas : CitiesOrAreas?
    lazy var CityTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = .clear
        tf.Icon.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tf.IconImage = UIImage(named: "Path")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        tf.addTarget(self, action: #selector(ActionCity), for: .editingDidBegin)
        tf.Icon.addTarget(self, action: #selector(ActionCity), for: .touchUpInside)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionCity)))
        tf.attributedPlaceholder = NSAttributedString(string: "City".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    let PickerCitiesAreas = UIPickerView()
    @objc func ActionCity() {
    let PopUp = PopUpDownView()
    PopUp.currentState = .open
    PopUp.modalPresentationStyle = .overFullScreen
    PopUp.modalTransitionStyle = .coverVertical
    PopUp.endCardHeight = ControlWidth(240)
    PopUp.radius = 25

    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    Label.text = "City".localizable
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

    lazy var HomeAddressTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.Icon.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tf.IconImage = UIImage(named: "Location")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 26)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Home Address".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var CompanyTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Company".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var WorkLocationTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.Icon.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tf.IconImage = UIImage(named: "Location")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 26)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Work Location".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var SaveChanges : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Save Changes".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSaveChanges), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionSaveChanges() {
    guard let Profile = Profile?.ProfileData?.profile else { return }
    if FullName.NoError() && EmailTF.NoError() && EmailTF.NoErrorEmail() && PhoneNumberTF.NoError() && !isValidNumber && GenderTF.NoError() {
    return
    }else{
    if IfChanges() == false && imageIsChanges == false {
    ShowMessageAlert("Error","Error".localizable, "There is no change in the data".localizable, true){}
    }else{
    if PhoneNumberTF.text != Profile.phone {
    let OTPUpdate = OTPUpdateProfile()
    OTPUpdate.Edit = self
    OTPUpdate.modalPresentationStyle = .overFullScreen
    OTPUpdate.modalTransitionStyle = .crossDissolve
    present(OTPUpdate, animated: true)
    }else{
    ProfileSaveChanges()
    }
    }
    }
    }
    
    var imageUrl : String?
    func ProfileSaveChanges() {
    if imageIsChanges == true {
    guard let image = ProfileImage.image else { return }
    guard let uid = getProfileObject().uid else { return }
    ViewDots.beginRefreshing()
    Storag(child1: uid, child2: "UserProfile" , image: image) { String in
    self.SaveChanges(imageUrl:String)
    } Err: { _ in
    self.ViewDots.endRefreshing {
    ShowMessageAlert("Error", "Error".localizable , "Update image Error".localizable, false, {})
    }
    }
    }else{
    SaveChanges(imageUrl: self.imageUrl ?? "")
    }
    }
    
    func IfChanges() -> Bool {
    if let Profile = Profile?.ProfileData?.profile  {
    let gender = Profile.male == false ? "FeMale".localizable : "Male".localizable
    if FullName.text == Profile.fullName &&
    EmailTF.text == Profile.email &&
    PhoneNumberTF.text == Profile.phone &&
    BirthdayTF.text == Profile.birthday &&
    CityTF.text == Profile.city &&
    HomeAddressTF.text == Profile.homeAddress &&
    CompanyTF.text == Profile.company &&
    WorkLocationTF.text == Profile.workLocation &&
    GenderTF.text == gender {
    return false
    }else{
    return true
    }
    }else{
    return false
    }
    }
    
    func SaveChanges(imageUrl:String = "") {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
        
    guard let CityId = cityId else{return}
    guard let Email = EmailTF.text else{return}
    guard let FullName = FullName.text else{return}
    guard let Birthday = BirthdayTF.text else{return}
    guard let PhoneNumber = PhoneNumberTF.text else{return}
    guard let gender = self.GenderTF.text == "Male".localizable ? true:false else{return}
        
    let Company = CompanyTF.text ?? ""
    let sqlId = getProfileObject().sqlId ?? ""
    let HomeAddress = HomeAddressTF.text ?? ""
    let WorkLocation = WorkLocationTF.text ?? ""
    let token = defaults.string(forKey: "jwt") ?? ""

        
    let api = "\(url + UpdateProfile)"

    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                    "platform": "I",
                                    "Lang": "lang".localizable,
                                    "SqlId": sqlId,
                                    "profileImge": imageUrl,
                                    "fullName": FullName,
                                    "email": Email,
                                    "phone": PhoneNumber,
                                    "birthday": Birthday,
                                    "cityId": CityId,
                                    "homeAddress": HomeAddress,
                                    "company": Company,
                                    "workLocation": WorkLocation,
                                    "male": gender]
        

    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.Profile?.ProfileData?.profile?.fullName = FullName
    self.Profile?.ProfileData?.profile?.phone = PhoneNumber
    self.Profile?.ProfileData?.profile?.birthday = Birthday
    self.Profile?.ProfileData?.profile?.cityId = CityId
    self.Profile?.ProfileData?.profile?.city = self.CityTF.text
    self.Profile?.ProfileData?.profile?.homeAddress = HomeAddress
    self.Profile?.ProfileData?.profile?.company = Company
    self.Profile?.ProfileData?.profile?.workLocation = WorkLocation
    self.Profile?.ProfileData?.profile?.male = gender
    self.Profile?.ProfileCollection.reloadData()
    self.ViewDots.endRefreshing("Success Save Changes".localizable, .success) {}
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [FullName,EmailTF,PhoneNumberTF,GenderTF,BirthdayTF,CityTF,HomeAddressTF,CompanyTF,WorkLocationTF,SaveChanges])
        Stack.axis = .vertical
        Stack.backgroundColor = .clear
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        return Stack
    }()

}


extension EditPersonalVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CityData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CityData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CityTF.text = CityData[row].name
        cityId = CityData[row].id
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
        label.text = CityData[row].name
        return label
    }
    
    func SetCity() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//        
//    let api = "\(url + GetCities)"
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let parameters:[String : Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                     "Platform": "I",
//                                     "lang": "lang".localizable]
//    
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [["id" : 1,"name" : "Cairo"],
                           ["id" : 2,"name" : "Alexandria"],
                           ["id" : 3,"name" : "Giza"],
                           ["id" : 4,"name" : "Shubra El Kheima"],
                           ["id" : 5,"name" : "Ismaïlia"],
                           ["id" : 6,"name" : "Aswān"]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            for item in data {
                self.CityData.append(City(dictionary: item))
                self.PickerCitiesAreas.reloadAllComponents()
            }
            
            self.ViewDots.endRefreshing() {}
            self.ViewNoData.isHidden = true
            self.ViewScroll.isHidden = false
        }
//    } Err: { (error) in
//    self.ViewScroll.isHidden = true
//    self.SetUpIsError(error, true, self.SetCity)
//    }
    }
}


