//
//  TermsOfServiceVC.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 01/08/2021.
//

import UIKit

class TermsOfServiceVC: ViewController , UITableViewDelegate, UITableViewDataSource {
    
    private let TermsID = "TermsId"
    var Terms : PrivacyAndTerms?
    
    override func viewDidLoad() {
    super.viewDidLoad()
    SetTerms()
    SetUpTableView()
    view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
        
    fileprivate func SetUpTableView() {
    view.addSubview(Dismiss)
    Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.TextLabel = "Terms & conditions".localizable
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
    view.addSubview(TableView)
    TableView.frame = CGRect(x: ControlX(5), y: Dismiss.frame.maxY + ControlX(15), width: view.frame.width - ControlX(10), height: view.frame.height - ControlWidth(85))
    }
    
    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.estimatedRowHeight = ControlWidth(80)
        tv.rowHeight = UITableView.automaticDimension
        tv.register(UITableViewCell.self, forCellReuseIdentifier: TermsID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: TermsID)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        cell.textLabel?.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = Terms?.body
        cell.textLabel?.addInterlineSpacing(spacingValue: ControlWidth(5))
        cell.textLabel?.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(16))
        return cell
    }
    
    func SetTerms() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//        
//    let api = "\(url + GetTermsAndConditions)"
//    let token = defaults.string(forKey: "jwt") ?? ""
//
//    let parameters:[String : Any] = ["lang": "lang".localizable]
//    
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = ["title":"Test String","body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world"] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            
            self.Terms = PrivacyAndTerms(dictionary: data)
            self.ViewDots.endRefreshing() {}
            self.TableView.SetAnimations()
            
            self.TableView.isHidden = false
            self.ViewNoData.isHidden = true
        }
//    } ArrayOfDictionary: { _ in
//    } Err: { (error) in
//    self.TableView.isHidden = true
//    self.SetUpIsError(error, true, self.SetTerms)
//    }
    }

}
