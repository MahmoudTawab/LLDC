//
//  ProfileHeader.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 09/08/2021.
//

import UIKit

protocol ProfileHeaderDelegate {
    func toggleSection(_ section: Int)
}

class ProfileHeader: UICollectionReusableView {

    var Delegate: ProfileHeaderDelegate?
    var section: Int = 0
    
    lazy var titleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(17))
        return Label
    }()
    
    lazy var EditButton : UIImageView = {
        let Image = UIImageView()
        Image.tintColor = .black
        Image.contentMode = .scaleAspectFit
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.9558447003, green: 0.9558447003, blue: 0.9558447003, alpha: 1)
        return View
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
        
        let Color = #colorLiteral(red: 0.9558447003, green: 0.9558447003, blue: 0.9558447003, alpha: 1).cgColor
        addSubview(BackgroundView)
        BackgroundView.frame = CGRect(x: ControlX(15), y: 0, width: self.frame.width - ControlX(30), height: self.frame.height)
        BackgroundView.roundCorners(corners: [.topLeft,.topRight], radius: ControlWidth(8), fillColor: Color, 0)

        BackgroundView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: BackgroundView.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: BackgroundView.heightAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: BackgroundView.widthAnchor, constant: ControlX(-50)).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor, constant: ControlX(15)).isActive = true
        
        BackgroundView.addSubview(EditButton)
        EditButton.centerYAnchor.constraint(equalTo: BackgroundView.centerYAnchor).isActive = true
        EditButton.heightAnchor.constraint(equalToConstant: ControlWidth(26)).isActive = true
        EditButton.widthAnchor.constraint(equalTo: EditButton.heightAnchor).isActive = true
        EditButton.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor, constant: ControlX(-15)).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileHeader.tapHeader(_:))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
    guard let cell = gestureRecognizer.view as? ProfileHeader else {
    return
    }
    Delegate?.toggleSection(cell.section)
    }

}

