//
//  NotificationsCell.swift
//  LLDC (iOS)
//
//  Created by Emoji Technology on 07/08/2021.
//

import UIKit
protocol NotificationsDelegate {
    func ActionView(cell:NotificationsCell)
}

class NotificationsCell: SwipeTableViewCell {
    

    var Delegate : NotificationsDelegate?
    lazy var LabelTitle : UIButton = {
        let Button = UIButton()
        Button.backgroundColor = .clear
        Button.titleLabel?.numberOfLines = 2
        Button.contentVerticalAlignment = .top
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.contentHorizontalAlignment = "lang".localizable == "ar" ? .right : .left
        Button.addTarget(self, action: #selector(ActionBackground), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(14))
        Button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        return Button
    }()
        
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBackground)))
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    @objc func ActionBackground() {
    Delegate?.ActionView(cell: self)
    }
   
    lazy var LabelDate : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(13))
        return Label
    }()
    
    lazy var ViewLine : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var ReadableView:UIView = {
        let View = UIView()
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.isHidden = true
        addSubview(BackgroundView)
        addSubview(ReadableView)
        addSubview(LabelTitle)
        addSubview(LabelDate)
        addSubview(ViewLine)

        BackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        BackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        BackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        ReadableView.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor,constant: ControlX(15)).isActive = true
        ReadableView.topAnchor.constraint(equalTo: BackgroundView.topAnchor,constant: ControlX(20)).isActive = true
        ReadableView.widthAnchor.constraint(equalToConstant: ControlWidth(10)).isActive = true
        ReadableView.heightAnchor.constraint(equalToConstant: ControlWidth(10)).isActive = true
        ReadableView.layer.cornerRadius = ControlX(5)
        
        ViewLine.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        ViewLine.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        ViewLine.topAnchor.constraint(equalTo: BackgroundView.topAnchor).isActive = true
        ViewLine.heightAnchor.constraint(equalToConstant: ControlWidth(0.4)).isActive = true
            
        LabelTitle.topAnchor.constraint(equalTo: BackgroundView.topAnchor,constant: ControlX(10)).isActive = true
        LabelTitle.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        LabelTitle.leadingAnchor.constraint(equalTo: ReadableView.leadingAnchor,constant: ControlX(20)).isActive = true
        LabelTitle.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor , constant: ControlX(-20)).isActive = true
        
        LabelDate.topAnchor.constraint(equalTo: LabelTitle.bottomAnchor,constant: ControlX(5)).isActive = true
        LabelDate.leadingAnchor.constraint(equalTo: LabelTitle.leadingAnchor).isActive = true
        LabelDate.widthAnchor.constraint(equalTo: LabelTitle.widthAnchor).isActive = true
        LabelDate.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
