//
//  AddFamilyVC.swift
//  LLDC
//
//  Created by Emojiios on 30/03/2022.
//

import UIKit
import FlagPhoneNumber

class AddFamilyVC: ViewController ,FPNTextFieldDelegate , MediaBrowserDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    
    var Profile:ProfileVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        GetDataFamilyRelation()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        
    view.addSubview(Dismiss)
    Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(40), width: view.frame.width - ControlX(30), height: ControlWidth(40))
       
    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlWidth(70))
        
    ViewScroll.addSubview(ViewBackground)
    ViewBackground.frame = CGRect(x: ControlX(15), y: 0, width: view.frame.width - ControlX(30), height: ControlWidth(540))
        
    ViewBackground.addSubview(ProfileImage)
    ProfileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    ProfileImage.widthAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
    ProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
    ProfileImage.topAnchor.constraint(equalTo: ViewBackground.topAnchor , constant: ControlY(25)).isActive = true
        
    ViewBackground.addSubview(ImageEdit)
    ImageEdit.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
    ImageEdit.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
    ImageEdit.trailingAnchor.constraint(equalTo: ProfileImage.trailingAnchor).isActive = true
    ImageEdit.topAnchor.constraint(equalTo: ProfileImage.bottomAnchor ,constant: ControlWidth(-35)).isActive = true

    ViewBackground.addSubview(StackItems)
    StackItems.heightAnchor.constraint(equalToConstant: ControlWidth(340)).isActive = true
    StackItems.topAnchor.constraint(equalTo: ProfileImage.bottomAnchor ,constant: ControlX(25)).isActive = true
    StackItems.leadingAnchor.constraint(equalTo: ViewBackground.leadingAnchor ,constant: ControlX(20)).isActive = true
    StackItems.trailingAnchor.constraint(equalTo: ViewBackground.trailingAnchor ,constant: ControlX(-20)).isActive = true
        
    ViewScroll.addSubview(Save)
    Save.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
    Save.leadingAnchor.constraint(equalTo: ViewBackground.leadingAnchor).isActive = true
    Save.trailingAnchor.constraint(equalTo: ViewBackground.trailingAnchor).isActive = true
    Save.topAnchor.constraint(equalTo: ViewBackground.bottomAnchor ,constant: ControlWidth(40)).isActive = true

    SetUpPhoneNumber()
    ViewScroll.updateContentViewSize(ControlWidth(50))
    }
    
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.isHidden = true
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()
    
    lazy var ViewBackground:UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.cornerRadius = ControlX(8)
        return View
    }()

    lazy var ProfileImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ImageView.backgroundColor = .clear
        ImageView.layer.masksToBounds = true
        ImageView.contentMode = .scaleAspectFill
        ImageView.image = UIImage(named: "Profile")
        ImageView.layer.borderWidth = ControlWidth(2)
        ImageView.layer.cornerRadius = ControlX(60)
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DidSelect)))
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

    var ImageIsEdit = false
    lazy var ImageEdit : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = .white
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.layer.shadowRadius = 4
        Button.layer.shadowOpacity = 0.2
        Button.layer.shadowOffset = .zero
        Button.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor
        Button.layer.cornerRadius = ControlX(20)
        Button.setImage(UIImage(named: "add"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage
        ImageIsEdit = true
        ProfileImage.image = image
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
    
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsEmail
        tf.keyboardType = .emailAddress
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Email".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
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

    lazy var Save : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Save".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSaveChanges), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()
    
    var MainData : Main?
    @objc func ActionSaveChanges() {
    if FullName.NoError() && PhoneNumberTF.NoError() && isValidNumber && EmailTF.NoError() && EmailTF.NoErrorEmail() && BirthdayTF.NoError() {

    if RelationId == nil {
    CollectionRelation.Shake()
    }else{
    if ImageIsEdit == true {
    guard let image = ProfileImage.image else { return }
    guard let uid = getProfileObject().uid else { return }
    let count = Profile?.ProfileData?.profile?.Family.count ?? 0 + 1
        
    ViewDots.beginRefreshing()
    Storag(child1: uid, child2: "FamilyUser", child3: "Family \(count)", image: image) { String in
        
    if self.Dismiss.TextLabel == "Add Family".localizable {
    self.FamilyMemberAdd(profilePhoto:String)
    }else{
    self.FamilyMemberEdit(profilePhoto:String)
    }
        
    } Err: { _ in
    self.ViewDots.endRefreshing {
    ShowMessageAlert("Error", "Error".localizable , "Update image Error".localizable, false, {})
    }
    }
    }else{
        
    if Dismiss.TextLabel == "Add Family".localizable {
    self.FamilyMemberAdd(profilePhoto: memberPhoto ?? "")
    }else{
    self.FamilyMemberEdit(profilePhoto: memberPhoto ?? "")
    }
        
    }
    }
    }
    }
    
    
    func FamilyMemberAdd(profilePhoto:String = "") {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    guard let senderName = self.Profile?.ProfileData?.profile?.fullName else{return}
    guard let FullName = FullName.text else{return}
    guard let Email = EmailTF.text else{return}
    guard let Phone = PhoneNumberTF.text else{return}
    guard let relation = RelationId else{return}
    guard let Birthday = BirthdayTF.text else{return}
        
    let api = "\(url + AddFamilyMember)"
    let sqlId = getProfileObject().sqlId ?? ""
    let token = defaults.string(forKey: "jwt") ?? ""

    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                   "platform":  "I",
                                   "lang": "lang".localizable,
                                   "sqlId": sqlId,
                                   "senderName": senderName,
                                   "profilePhoto": profilePhoto,
                                   "fullName": FullName,
                                   "email": Email,
                                   "phone": Phone,
                                   "birthday": Birthday,
                                   "relationId": relation]
        
    ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { _ in
    } ArrayOfDictionary: { data in
    self.Profile?.ProfileData?.profile?.Family.removeAll()
    for item in data {
    self.Profile?.ProfileData?.profile?.Family.append(FamilyMembers(dictionary: item))
    self.Profile?.ProfileCollection.reloadData()
    }
     
    self.ViewDots.endRefreshing("Success".localizable + " " + "Add Family".localizable , .success) {
    self.FullName.text = ""
    self.EmailTF.text = ""
    self.PhoneNumberTF.text = ""
    self.RelationId = nil
    self.BirthdayTF.text = ""
    }
    } Err: { error in
    guard let uid = getProfileObject().uid else { return }
    let count = self.Profile?.ProfileData?.profile?.Family.count ?? 0 + 1
    StoragRemove(child1: uid, child2: "FamilyUser", child3: "Family \(count)")
    self.ViewDots.endRefreshing(error, .error, {})
    }
    }
    
    var memberId : String?
    var memberPhoto : String?
    func FamilyMemberEdit(profilePhoto:String = "") {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    guard let memberId = memberId else{return}
    guard let FullName = FullName.text else{return}
    guard let Email = EmailTF.text else{return}
    guard let Phone = PhoneNumberTF.text else{return}
    guard let relation = RelationId else{return}
    guard let Birthday = BirthdayTF.text else{return}
        
    let api = "\(url + UpdateFamilyMember)"
    let sqlId = getProfileObject().sqlId ?? ""
    let token = defaults.string(forKey: "jwt") ?? ""
    
    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                   "platform":  "I",
                                   "lang": "lang".localizable,
                                   "sqlId": sqlId,
                                   "memberId": memberId,
                                   "profilePhoto": profilePhoto,
                                   "fullName": FullName,
                                   "email": Email,
                                   "phone": Phone,
                                   "birthday": Birthday,
                                   "relationId": relation]
    
    ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { _ in
    } ArrayOfDictionary: { data in
    self.Profile?.ProfileData?.profile?.Family.removeAll()
    for item in data {
    self.Profile?.ProfileData?.profile?.Family.append(FamilyMembers(dictionary: item))
    self.Profile?.ProfileCollection.reloadData()
    }
    self.ViewDots.endRefreshing("Success".localizable + " " + "Edit Family".localizable, .success) {self.Profile?.GetProfileData()}
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error, {})
    }
    }
    
    lazy var LabelRelation : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Relation".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(16))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Label
    }()
    
    var RelationId : Int?
    var RelationID = "Relation"
    var RelationSelect : IndexPath?
    var Relation = [FamilyRelation]()
    lazy var CollectionRelation: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = UIColor.clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(RelationCell.self, forCellWithReuseIdentifier: RelationID)
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: ControlX(5))
        vc.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return vc
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return Relation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelationID, for: indexPath) as! RelationCell
    cell.RelationLabel.text = Relation[indexPath.item].name
    cell.layer.borderWidth = ControlWidth(1)
    cell.layer.cornerRadius = cell.frame.height / 2
    cell.backgroundColor = RelationSelect?.item == indexPath.item ?  #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1) : UIColor.clear
    cell.RelationLabel.textColor = RelationSelect?.item == indexPath.item ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let nw = Relation[indexPath.item].name ?? ""
        let estimatedFrame = nw.textSizeWithFont(UIFont.systemFont(ofSize: ControlWidth(15)))
        return CGSize(width: estimatedFrame.width + ControlWidth(70), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let Cell = CollectionRelation.cellForItem(at: indexPath) {
        UIView.animate(withDuration: 0.1, animations: {
        Cell.transform = Cell.transform.scaledBy(x: 0.8, y: 0.8)
        self.RelationId = self.Relation[indexPath.item].Id
        self.RelationSelect = indexPath
        }, completion: { _ in
        UIView.animate(withDuration: 0.1, animations: {
        Cell.transform = .identity
        }, completion: { _ in
        self.CollectionRelation.reloadData()
        })
        })
        }
    }
    
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [FullName,PhoneNumberTF,EmailTF,BirthdayTF,LabelRelation,CollectionRelation])
        Stack.axis = .vertical
        Stack.backgroundColor = .clear
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    func GetDataFamilyRelation() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//        
//    let api = "\(url + GetFamilyRelation)"
//    let token = defaults.string(forKey: "jwt") ?? ""
//
//    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                   "platform": "I",
//                                   "lang": "lang".localizable]
                                       
            
    ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
  
        let data = [["Id" : 1,"name" : "my dad"],
                           ["Id" : 2,"name" : "My mom"],
                           ["Id" : 3,"name" : "my sister"],
                           ["Id" : 4,"name" : "my brother"],
                           ["Id" : 5,"name" : "my wife"],
                           ["Id" : 6,"name" : "my son"]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            
            for item in data {
                self.Relation.append(FamilyRelation(dictionary: item))
                self.CollectionRelation.reloadData()
                
                if self.Relation.count == data.count {
                    if let Index = self.Relation.firstIndex(where: {$0.Id == self.RelationId}) {
                        self.RelationSelect = IndexPath(item: Index, section: 0)
                        self.CollectionRelation.reloadData()
                    }
                }
            }
            
            self.ViewDots.endRefreshing() {}
            self.ViewNoData.isHidden = true
            self.ViewScroll.isHidden = false
        }
        
//    } Err: { error in
//    self.ViewScroll.isHidden = true
//    self.SetUpIsError(error, true, self.GetDataFamilyRelation)
//    }
    }
}

