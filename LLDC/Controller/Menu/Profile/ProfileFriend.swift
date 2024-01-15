//
//  ProfileFriend.swift
//  LLDC
//
//  Created by Emojiios on 30/03/2022.
//

import UIKit
import FlagPhoneNumber

protocol ProfileFooterDelegate {
    func ActionRecommendFriend(cell:ProfileFriend,First:String,Last:String,Phone:String,email:String)
}

class ProfileFriend: UICollectionViewCell ,FPNTextFieldDelegate {

    var Profile:ProfileVC?
    var Delegate: ProfileFooterDelegate?
    
    lazy var FirstName : FloatingTF = {
        let tf = FloatingTF()
        tf.attributedPlaceholder = NSAttributedString(string: "First name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    lazy var LastName : FloatingTF = {
        let tf = FloatingTF()
        tf.attributedPlaceholder = NSAttributedString(string: "Last name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var StackName : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [FirstName,LastName])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        return Stack
    }()

    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var repository: FPNCountryRepository = FPNCountryRepository()
    lazy var PhoneNumberTF : FPNTextField = {
        let tf = FPNTextField()
        tf.displayMode = .list
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
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
        guard let profile = Profile else { return }
        profile.present(navigationViewController, animated: true)
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
    
    lazy var Recommend : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Recommend".localizable, for: .normal)
        Button.addTarget(self, action: #selector(ActionRecommend), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionRecommend() {
    if FirstName.NoError() && LastName.NoError() && PhoneNumberTF.NoError() && isValidNumber && EmailTF.NoError() && EmailTF.NoErrorEmail() {
    guard let Phone = PhoneNumberTF.text else { return }
    guard let First = FirstName.text else { return }
    guard let Last =  LastName.text else { return }
    guard let email = EmailTF.text else { return }
    Delegate?.ActionRecommendFriend(cell: self,First: First, Last: Last, Phone: Phone, email: email)
    }
    }
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [StackName,PhoneNumberTF,EmailTF,Recommend])
        Stack.axis = .vertical
        Stack.spacing = ControlX(15)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = #colorLiteral(red: 0.9558447003, green: 0.9558447003, blue: 0.9558447003, alpha: 1)
        return Stack
    }()
    
    lazy var RecommendFriend : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.backgroundColor = .clear
        Button.semanticContentAttribute = .forceRightToLeft
        Button.setImage(UIImage(named: "right-arrow"), for: .normal)
        Button.setTitle("RecommendFriend".localizable, for: .normal)
        Button.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        Button.contentHorizontalAlignment = "lang".localizable == "ar" ? .right : .left
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1), for: .normal)
        return Button
    }()
    
    lazy var BackgroundView:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.9558447003, green: 0.9558447003, blue: 0.9558447003, alpha: 1)
        View.layer.cornerRadius = ControlX(10)
        return View
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
        
        addSubview(RecommendFriend)
        RecommendFriend.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: ControlWidth(40))

        addSubview(BackgroundView)
        BackgroundView.frame = CGRect(x: 0, y: RecommendFriend.frame.maxY + ControlX(10), width: self.frame.width, height: ControlWidth(280))

        BackgroundView.addSubview(Stack)
        Stack.frame = CGRect(x: ControlX(15), y: ControlX(15), width: BackgroundView.frame.width - ControlX(30), height: BackgroundView.frame.height - ControlX(30))
        
        SetUpPhoneNumber()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

