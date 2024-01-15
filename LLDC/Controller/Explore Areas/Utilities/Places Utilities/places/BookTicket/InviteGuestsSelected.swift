//
//  InviteGuestsSelected.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 26/07/2021.
//

import UIKit

struct GuestsSelected : Codable {
    var email1 : String?
    var fName : String?
    var phoneNumber1 : String?
}

class InviteGuestsSelected: ViewController, UITableViewDelegate, UITableViewDataSource {

    let InviteGuestsID = "CellId"
    static var Image = [UIImage]()
    static var IdSelect = [String]()
    static var Guests = [GuestsSelected]()
    var InviteGuests : InviteGuestsVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        TableView.SetAnimations()
    }

    fileprivate func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Dismiss.TextLabel = "Selected Guests".localizable
        Dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DismissAction)))
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
        view.addSubview(TableView)
        TableView.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlX(10), width: view.frame.width , height: view.frame.height - ControlHeight(80))
        
        TableView.tableHeaderView = HeaderView
        HeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width , height: ControlWidth(115))
        
        HeaderView.addSubview(TextView)
        TextView.frame = CGRect(x: ControlX(15), y: ControlX(10), width: HeaderView.frame.width - ControlX(30), height: ControlWidth(60))
        
        HeaderView.addSubview(SelectedGuests)
        SelectedGuests.frame = CGRect(x: ControlX(15), y: TextView.frame.maxY + ControlX(10), width: view.frame.width - ControlX(30), height: ControlWidth(25))
        
        TableView.tableFooterView = FooterView
        FooterView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ControlWidth(90))
        
        FooterView.addSubview(Confirm)
        Confirm.frame = CGRect(x: ControlX(15), y: ControlX(20), width: FooterView.frame.width - ControlX(30), height: ControlWidth(50))
        
        TableView.reloadData()
    }

    @objc func DismissAction() {
    InviteGuestsSelected.IdSelect.removeAll()
    InviteGuestsSelected.Guests.removeAll()
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var HeaderView:UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        return View
    }()
    
    lazy var TextView : UITextView = {
        let TV = UITextView()
        TV.backgroundColor = .clear
        TV.isEditable = false
        TV.isSelectable = false
        TV.keyboardAppearance = .light
        TV.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(16))
        TV.textColor = UIColor(red: 99/255, green: 87/255, blue: 82/255, alpha: 1)
        TV.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        TV.text = "QR code will be generated automatically and sent in a link format by SMS to the invited guests".localizable
        return TV
    }()
    
    lazy var SelectedGuests : UILabel = {
        let Label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Selected Guests".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        ])
        
        let count = "lang".localizable == "ar" ? "\(InviteGuestsSelected.Guests.count)".NumAR() : "\(InviteGuestsSelected.Guests.count)"
        attributedString.append(NSAttributedString(string: "  ( \(count) )", attributes: [
            .font: UIFont(name: "SourceSansPro-Regular", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        ]))
        Label.attributedText = attributedString
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.rowHeight = ControlWidth(80)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(10), right: 0)
        tv.register(InviteGuestsSelectedCell.self, forCellReuseIdentifier: InviteGuestsID)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InviteGuestsSelected.Guests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InviteGuestsID, for: indexPath) as! InviteGuestsSelectedCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.ProfileImage.image = InviteGuestsSelected.Image[indexPath.row]
        cell.NameLabel.text = InviteGuestsSelected.Guests[indexPath.row].fName
        cell.PhoneLabel.text = InviteGuestsSelected.Guests[indexPath.row].phoneNumber1
        return cell
    }
    
    lazy var FooterView:UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        return View
    }()
    
    lazy var Confirm : ButtonNotEnabled = {
    let Button = ButtonNotEnabled(type: .system)
    Button.Radius = false
    Button.clipsToBounds = true
    Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Button.setTitle("Confirm".localizable, for: .normal)
    Button.addTarget(self, action: #selector(ActionConfirm), for: .touchUpInside)
    Button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(18))
    Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
    return Button
    }()

    @objc func ActionConfirm() {
    self.navigationController?.popViewController(animated: false)
    InviteGuests?.navigationController?.popViewController(animated: true)
    }

}
