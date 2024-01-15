//
//  AboutVC.swift
//  Color
//
//  Created by Mahmoud Tawab on 6/1/20.
//  Copyright © 2020 Mahmoud Abd El Tawab. All rights reserved.
//

import UIKit
import SDWebImage

class AboutVC: ViewController ,UITableViewDelegate ,UITableViewDataSource  {

    var AboutData : About?
    var headerView = UIView()
    var headerMaskLayer: CAShapeLayer!
    private let kTableHeaderCutAway: CGFloat = 0.0
    private let kTableHeaderHeight: CGFloat = ControlWidth(160)
    
    override func viewDidLoad() {
    super.viewDidLoad()
    SetAbout()
    SetUpTableView()
    view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    fileprivate func SetUpTableView() {
    view.addSubview(Dismiss)
    Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.TextLabel = "About Le Lac Du".localizable
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
    view.addSubview(TableView)
    TableView.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(10) , width: view.frame.width, height: view.frame.height - (Dismiss.frame.maxY + ControlY(15)))
        
    SetUpHeader()
    }
    
    let AboutId = "About"
    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.alwaysBounceVertical = false
        tv.rowHeight = UITableView.automaticDimension
        tv.register(AboutCell.self, forCellReuseIdentifier: AboutId)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        return tv
    }()
    
    
    func SetUpHeader() {
        headerView = TableView.tableHeaderView ?? UIView()
        headerView.backgroundColor = .clear
        TableView.tableHeaderView = nil
        TableView.addSubview(headerView)

        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        TableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        TableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
            
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
           
        updateHeaderView()
        headerView.addSubview(ImageAbout)
    }
    
    lazy var ImageAbout : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.image = UIImage(named: "Group 26056")
        return ImageView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AboutData?.Details.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AboutId, for: indexPath as IndexPath) as! AboutCell
        cell.selectionStyle = .none
        cell.TextTitle.text = AboutData?.Details[indexPath.row].title ?? ""
        cell.TheDetails.text = AboutData?.Details[indexPath.row].body ?? ""
        cell.TheDetails.addInterlineSpacing(spacingValue: ControlWidth(4))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func updateHeaderView() {
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: TableView.bounds.width, height: kTableHeaderHeight)
        if TableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = TableView.contentOffset.y
            headerRect.size.height = -TableView.contentOffset.y + kTableHeaderCutAway/2
        }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height-kTableHeaderCutAway))
        headerMaskLayer?.path = path.cgPath
        
        headerView.frame = headerRect
        ImageAbout.frame = CGRect(x: ControlX(15), y: ControlX(5), width: headerView.frame.width - ControlX(30), height: headerView.frame.height - ControlX(10))
    }
    
    
    func SetAbout() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let api = "\(url + GetAboutUs)"
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let parameters:[String : Any] = ["lang": "lang".localizable]
//        
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = ["coverPhotoPath":"https://pics.craiyon.com/2023-10-15/6c68abc164ca42ddae72051b1239bf83.webp","details":[["title":"Test String","body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world"],
                                                                                                                             
            ["title":"Test String","body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world"],
                                                                                                                             
            ["title":"Test String","body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world"],
                                                                                                                             
            ["title":"Test String","body":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France, and the French have continued to make major contributions to the restaurant’s development.A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world A look at France's historic restaurant culture and what sets its cuisine apart from the rest of the world"]]] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            
            self.AboutData = About(dictionary: data)
            self.ViewDots.endRefreshing() {}
            self.TableView.SetAnimations()
            self.ImageAbout.sd_setImage(with: URL(string: self.AboutData?.coverPhotoPath ?? "")
                                        , placeholderImage: UIImage(named: "Group 26056"))
            
            self.TableView.isHidden = false
            self.ViewNoData.isHidden = true
        }
//    } ArrayOfDictionary: { _ in
//    } Err: { (error) in
//    self.TableView.isHidden = true
//    self.SetUpIsError(error, true, self.SetAbout)
//    }
    }
}


