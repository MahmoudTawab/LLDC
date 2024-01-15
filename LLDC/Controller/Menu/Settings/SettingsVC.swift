//
//  SettingsVC.swift
//  LLDC
//
//  Created by Emojiios on 03/04/2022.
//

import UIKit

class SettingsVC: ViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    let SettingsId = "Settings"
    var SettingsImage = ["Settings1"]
    
    var SettingsTitel = ["Notification Settings".localizable]
    var SettingsDetails = ["Check your notifications settings".localizable]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        SettingsCollection.SetAnimations()
    }
    
    fileprivate func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Dismiss.TextLabel = "Settings".localizable
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
        view.addSubview(SettingsCollection)
        SettingsCollection.topAnchor.constraint(equalTo: Dismiss.bottomAnchor, constant: ControlY(10)).isActive = true
        SettingsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        SettingsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        SettingsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
        
    lazy var SettingsCollection: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ControlX(15)
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        vc.register(HelpCell.self, forCellWithReuseIdentifier: SettingsId)
        return vc
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SettingsTitel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsId, for: indexPath) as! HelpCell

    cell.HelpTitel.text = SettingsTitel[indexPath.item]
    cell.HelpDetails.text = SettingsDetails[indexPath.item]
    cell.ImageView.image = UIImage(named: SettingsImage[indexPath.item])
    cell.roundCorners(topLeft: ControlX(2), topRight: ControlX(12), bottomLeft: ControlX(8), bottomRight: ControlX(12))
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - ControlX(30), height: ControlWidth(80))
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
    Present(ViewController: self, ToViewController: NotificationSettingsVC())
    default: break}
    }

}


