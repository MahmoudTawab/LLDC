//
//  NotificationSettingsVC.swift
//  LLDC
//
//  Created by Emojiios on 03/04/2022.
//

import UIKit

class NotificationSettingsVC: ViewController ,NotificationSettingsDelegate , UITableViewDelegate , UITableViewDataSource {
    
    let CellId = "NotificationSettings"
    var Settings = ["Newsletter notifications","Featured events notifications","Happening now events notifications","Area updates notifications","Special offers notifications","My events reminder notifications"]
    
    override func viewDidLoad() {
    super.viewDidLoad()
    SetUpTableView()
    view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    TableView.SetAnimations()
    }
    
    fileprivate func SetUpTableView() {
    view.addSubview(Dismiss)
    Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.TextLabel = "Notification Settings".localizable
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
    view.addSubview(TableView)
    TableView.topAnchor.constraint(equalTo: Dismiss.bottomAnchor, constant: ControlY(10)).isActive = true
    TableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    TableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    TableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.rowHeight = ControlWidth(70)
        tv.alwaysBounceVertical = false
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(NotificationSettingsCell.self, forCellReuseIdentifier: CellId)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        return tv
    }()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! NotificationSettingsCell
    cell.selectionStyle = .none
    cell.Delegate = self
    cell.TextTitle.text = Settings[indexPath.row]
    cell.Switch.onTintColor = cell.Switch.isOn == false ?   #colorLiteral(red: 0.8275709748, green: 0.841716826, blue: 0.8346990943, alpha: 1) : #colorLiteral(red: 0.3505077368, green: 0.3505077368, blue: 0.3505077368, alpha: 1)
    cell.Switch.thumbTintColor = cell.Switch.isOn == true ? #colorLiteral(red: 0.4506688118, green: 0.5467630625, blue: 0.6229500175, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    return cell
    }
    
    func SwitchUpdate(Cell: NotificationSettingsCell) {
    Cell.Switch.thumbTintColor = Cell.Switch.isOn == true ? #colorLiteral(red: 0.4506688118, green: 0.5467630625, blue: 0.6229500175, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
}
    
  
