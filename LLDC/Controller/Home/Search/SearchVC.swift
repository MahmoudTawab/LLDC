//
//  SearchVC.swift
//  LLDC
//
//  Created by Emojiios on 10/04/2022.
//

import UIKit
import Firebase

class SearchVC: ViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var SearchData = [Search]()
    var SearchSave = [Search]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        SetUpItems()
        RecentSearches()
    }
    
    fileprivate func SetUpItems() {
    
    view.addSubview(Dismiss)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
    
    view.addSubview(SearchTextField)
    SearchTextField.translatesAutoresizingMaskIntoConstraints = false
    SearchTextField.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
    SearchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: ControlY(40)).isActive = true
    SearchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(60)).isActive = true
    SearchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant:  ControlX(-15)).isActive = true
    SearchTextField.layer.cornerRadius = ControlWidth(20)
        
    view.addSubview(SearchIcon)
    SearchIcon.translatesAutoresizingMaskIntoConstraints = false
    SearchIcon.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    SearchIcon.widthAnchor.constraint(equalTo: SearchIcon.heightAnchor).isActive = true
    SearchIcon.centerYAnchor.constraint(equalTo: SearchTextField.centerYAnchor).isActive = true
    SearchIcon.trailingAnchor.constraint(equalTo: SearchTextField.trailingAnchor , constant:  ControlX(-10)).isActive = true
        
    view.addSubview(StackNoContent)
    StackNoContent.frame = CGRect(x: ControlX(30), y: ControlWidth(180), width: view.frame.width - ControlX(60), height: ControlWidth(380))
        
    view.addSubview(SearchTable)
    SearchTable.topAnchor.constraint(equalTo: SearchTextField.bottomAnchor, constant: ControlY(10)).isActive = true
    SearchTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    SearchTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    SearchTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    SearchWorkersAsPerText()
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,object: nil, queue: OperationQueue.main,using: keyboardWillShowNotification)
        
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,object: nil, queue: OperationQueue.main,
        using: keyboardWillHideNotification)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShowNotification(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        EdgeInsets(top: 0, bottom: keyboardSize.height + 10)
    }
    
    func keyboardWillHideNotification(notification: Notification) {
    EdgeInsets(top: 0, bottom: 10)
    }
    
    func EdgeInsets(top:CGFloat,bottom:CGFloat) {
        let contentInsets = UIEdgeInsets(top: top, left: 0.0, bottom: bottom, right: 0.0)
        SearchTable.contentInset = contentInsets
        SearchTable.scrollIndicatorInsets = contentInsets
    }
    
    lazy var SearchTextField : UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .clear
        tf.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.delegate = self
        tf.returnKeyType = .search
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
        tf.addTarget(self, action: #selector(SearchWorkersAsPerText), for: .editingChanged)
        return tf
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let indexPath = SearchData.firstIndex(where: {$0.KeyWord == textField.text?.lowercased()}) {
        let SearchItem = SearchItemVC()
        SearchItem.keyWord = SearchData[indexPath].KeyWord
        SearchItem.keyWordId = SearchData[indexPath].KeyWordId
        Present(ViewController: self, ToViewController: SearchItem)
        }else{
        let SearchItem = SearchItemVC()
        SearchItem.keyWordId = ""
        SearchItem.keyWord = textField.text
        Present(ViewController: self, ToViewController: SearchItem)
        }
            
        return true
    }
    
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
    SearchData.removeAll()
    SearchTable.reloadData()
    ShowNoContent(Show:true)
    }
    
    func ShowNoContent(Show:Bool) {
    UIView.animate(withDuration: 0.5, animations: {
    if Show {
    self.StackNoContent.alpha = 1
    self.SearchTable.alpha = 0
    }else{
    self.StackNoContent.alpha = self.SearchData.count == 0 ? 1 : 0
    self.SearchTable.alpha = self.SearchData.count != 0 ? 1 : 0
    }
    })
    }
    
    
    lazy var StackNoContent : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ImageNoContent,LabelNoContent])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(20)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var ImageNoContent : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Group 57998")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.heightAnchor.constraint(equalToConstant: ControlWidth(300)).isActive = true
        return ImageView
    }()
    
    lazy var LabelNoContent : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.textAlignment = .center
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(16))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        Label.text = "No results were found for your search, please try again with a different word".localizable
        return Label
    }()
    
    var SearchIconShow = false
    @objc func SearchWorkersAsPerText() {
    guard let text = SearchTextField.text else{return}
    let path = Firestore.firestore().collection("Search").whereField("KeyWord", isGreaterThanOrEqualTo: text.lowercased()).whereField("KeyWord", isLessThanOrEqualTo: text.lowercased() + "\u{F7FF}")
    path.addSnapshotListener { (query, error) in
    if error != nil {
    self.ShowNoContent(Show:true)
    return
    }
        
    guard let doucments = query?.documents else {return}
    self.SearchData.removeAll()
    self.SearchTable.reloadData()
    doucments.forEach { Snapshot in

    if text.count < 1 {
    if self.SearchSave.count != 0 {
    self.SearchIconShow = true
    self.SearchData = self.SearchSave
    self.SearchTable.reloadData()
    }else{
    self.ShowNoContent(Show:true)
    }
    }else{
    self.SearchData.append(Search(Data: Snapshot.data()))
    self.SearchIconShow = false
    self.SearchTable.reloadData()
    self.ShowNoContent(Show:false)
    }
        
    }
    }
    }
    
    let SearchId = "SearchId"
    lazy var SearchTable : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.alpha = 0
        tv.delegate = self
        tv.dataSource = self
        tv.separatorColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tv.backgroundColor = .clear
        tv.rowHeight = ControlWidth(50)
        tv.keyboardDismissMode = .interactive
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: SearchId)
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(10), right: 0)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchId, for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cell.imageView?.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cell.textLabel?.text = SearchData[indexPath.row].KeyWord
        cell.textLabel?.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(18))
        cell.imageView?.image = SearchIconShow == true ? UIImage(named: "clock")?.imageWithImage(scaledToSize: CGSize(width: ControlWidth(18), height: ControlWidth(18))) : UIImage(named: "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let Header = UIView()
        Header.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        Header.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: ControlWidth(35))
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(20))
        Label.text = SearchIconShow == true ? "Recent Searches".localizable : "Search Results".localizable
        
        Header.addSubview(Label)
        Label.frame = CGRect(x: ControlX(15), y: 0, width: Header.frame.width - ControlX(30), height: Header.frame.height)
        return Header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ControlWidth(35)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SearchItem = SearchItemVC()
        SearchItem.keyWord = SearchData[indexPath.row].KeyWord
        SearchItem.keyWordId = SearchData[indexPath.row].KeyWordId
        Present(ViewController: self, ToViewController: SearchItem)
    }
    
    @objc func RecentSearches() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//
//    let api = "\(url + GetRecentSearches)"
//    let sqlId = getProfileObject().sqlId ?? ""
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                   "Platform": "I",
//                                   "SqlId": sqlId,
//                                   "deviceId": udid]
//        
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [["KeyWordId" : "5ece8057-aae9-4df6-82a0-37a64c0078ff","KeyWord" : "the"],["KeyWordId" : "c6f4e5d3-265e-4693-b892-b65639c6624a","KeyWord" : "activity"],
                          ["KeyWordId" : "7be7bcec-9699-46d5-8565-e2ffea63a33e","KeyWord" : "ac"],["KeyWordId" : "77aea19a-832d-446e-974d-c935d1eb8618","KeyWord" : "aa"],
                          ["KeyWordId" : "1cb66002-c563-4406-8747-705803621e2e","KeyWord" : "a"],["KeyWordId" : "ec577ea6-8847-4603-8868-65950b7ce880","KeyWord" : "اي حاجة"]]
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            
            for item in data {
                self.SearchIconShow = true
                self.SearchSave.append(Search(Data: item))
                self.SearchData.append(Search(Data: item))
                self.ShowNoContent(Show:false)
                self.SearchTable.SetAnimations()
            }
            self.ViewDots.endRefreshing {}
            
        }
//    } Err: { _ in
//    self.ViewDots.endRefreshing {}
//    }
    }
    
}
