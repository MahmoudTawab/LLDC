//
//  HelpVC.swift
//  Bnkit
//
//  Created by Mohamed Tawab on 05/02/2021.
//  Copyright © 2021 Mahmoud Tawab. All rights reserved.
//

import UIKit

class HelpVC : ViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    let HelpId = "Help"
    var HelpImage = ["Help1","Help2","Help3","Help4","Help5","Help6","Help7","Help8","Help9"]
    
    var HelpTitel = ["FAQ".localizable,"Send Message".localizable,"Chat".localizable,"Call Us".localizable,
                     "About".localizable,"Privacy Policy".localizable,"Terms & Conditions".localizable]
    
    var HelpDetails = ["Find the answer you are looking for now!".localizable,"Message us if you have any inquiries!".localizable,
                     "Start chatting with us now!".localizable,"Call us now to learn more!".localizable,
                     "More about us and what we do!".localizable,"Know more about privacy policy!".localizable,
                     "Get to know our terms of service!".localizable]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        HelpCollection.SetAnimations()
    }

    
    fileprivate func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.IconImage.tintColor = .black
        Dismiss.TextLabel = "Help".localizable
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
        view.addSubview(HelpCollection)
        HelpCollection.topAnchor.constraint(equalTo: Dismiss.bottomAnchor, constant: ControlY(10)).isActive = true
        HelpCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        HelpCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        HelpCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
        
    lazy var HelpCollection: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ControlX(15)
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        vc.register(HelpCell.self, forCellWithReuseIdentifier: HelpId)
        return vc
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HelpTitel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HelpId, for: indexPath) as! HelpCell

    cell.HelpTitel.text = HelpTitel[indexPath.item]
    cell.HelpDetails.text = HelpDetails[indexPath.item]
    cell.ImageView.image = UIImage(named: HelpImage[indexPath.item])
    cell.roundCorners(topLeft: ControlX(2), topRight: ControlX(12), bottomLeft: ControlX(8), bottomRight: ControlX(12))
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - ControlX(30), height: ControlWidth(80))
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
    Present(ViewController: self, ToViewController: FAQVC())  
    case 1:
    Present(ViewController: self, ToViewController: SendMessageVC())
    case 2:
    guard let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(01003990090)&text=_Good%20Job%20Tawab_") else {return}
    if UIApplication.shared.canOpenURL(whatsappURL) {
    if #available(iOS 10.0, *) {
    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
    }else {
    UIApplication.shared.openURL(whatsappURL)
    }
    }
    case 3:
    guard let url = URL(string: "telprompt://\(01003990090)"),
    UIApplication.shared.canOpenURL(url) else {
    return
    }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
    case 4:
    Present(ViewController: self, ToViewController: AboutVC())
    case 5:
    Present(ViewController: self, ToViewController: PrivacyPolicyVC())
    case 6:
    Present(ViewController: self, ToViewController: TermsOfServiceVC())
    default: break}
    }

}


