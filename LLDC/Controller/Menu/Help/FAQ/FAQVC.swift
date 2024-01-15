//
//  FAQVC.swift
//  LLDC
//
//  Created by Emojiios on 02/04/2022.
//

import UIKit

class FAQVC : ViewController , UITableViewDelegate , UITableViewDataSource {
    
    let FAQId = "FAQ"
    var FAQData = [FAQ]()
    override func viewDidLoad() {
    super.viewDidLoad()
    SetFAQData()
    SetUpTableView()
    view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    fileprivate func SetUpTableView() {
    view.addSubview(Dismiss)
    Dismiss.IconImage.tintColor = .black
    Dismiss.TextLabel = "FAQ".localizable
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
        tv.isHidden = true
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(FAQCell.self, forCellReuseIdentifier: FAQId)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        return tv
    }()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return FAQData.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FAQId, for: indexPath) as! FAQCell
    cell.selectionStyle = .none
    
    cell.TextTitle.text = FAQData[indexPath.row].title
    cell.TheDetails.text = FAQData[indexPath.row].body
    cell.TheDetails.addInterlineSpacing(spacingValue: ControlWidth(4))
        
    cell.TheDetails.isHidden = FAQData[indexPath.row].FAQHidden
    cell.TextTitle.textColor = FAQData[indexPath.row].FAQHidden == false ? #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1) : #colorLiteral(red: 0.4317458444, green: 0.4317458444, blue: 0.4317458444, alpha: 1)
    cell.OpenClose.transform = FAQData[indexPath.row].FAQHidden == false ? .identity:CGAffineTransform(rotationAngle: "lang".localizable == "ar" ? (.pi / 2):(-.pi / 2))
    cell.TextTitle.font = FAQData[indexPath.row].FAQHidden == false ? UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18)) : UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    FAQData[indexPath.row].FAQHidden = !FAQData[indexPath.row].FAQHidden
    TableView.reloadRows(at: [indexPath], with: .automatic)
    TableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    
    func SetFAQData() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//        
//    let api = "\(url + GetFAQ)"
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let parameters:[String:Any] = ["lang": "lang".localizable]
//
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [["id":"","title":"Test String","body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world"],
                          
            ["id":"","title":"Test String","body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world"],
                    
            ["id":"","title":"Test String","body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world"],
                          
            ["id":"","title":"Test String","body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world"],
                          
            ["id":"","title":"Test String","body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world"],
                          
           ["id":"","title":"Test String","body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world"]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            for item in data {
                self.FAQData.append(FAQ(dictionary: item))
                self.TableView.SetAnimations()
            }
            self.ViewDots.endRefreshing(){}
            self.ViewNoData.isHidden = true
            self.TableView.isHidden = false
            
        }
//    } Err: { error in
//    self.TableView.isHidden = true
//    self.SetUpIsError(error,true) {self.SetFAQData()}
//    }
    }

}
