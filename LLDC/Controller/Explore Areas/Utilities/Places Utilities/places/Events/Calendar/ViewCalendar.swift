//
//  ViewCalendar.swift
//  LLDC
//
//  Created by Emojiios on 14/06/2022.
//

import UIKit

protocol ViewCalendarDelegate {
    func BookTicket(View:ViewCalendar)
}

class ViewCalendar: UIView  {

    var selectedDate = Date()
    var DaysSelect = [PlaceSchedule]()
    var ScheduleDate = [PlaceSchedule]()
    var totalSquares = [PlaceSchedule]()
    var Delegate:ViewCalendarDelegate?
    lazy var SelectDate : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Select Date".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(20))
        return Label
    }()
    
    lazy var monthLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(20))
        return Label
    }()
    
    lazy var PreviousButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.backgroundColor = .clear
        Button.setImage(UIImage(named: "Path"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionPrevious), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Button.transform = "lang".localizable == "ar" ? CGAffineTransform(rotationAngle: -.pi / 2) : CGAffineTransform(rotationAngle: .pi / 2)
        return Button
    }()
    
    @objc func ActionPrevious() {
    selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
    setWeekView()
    }
    
    lazy var NextButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.backgroundColor = .clear
        Button.setImage(UIImage(named: "Path"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionNext), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Button.transform = "lang".localizable == "ar" ?  CGAffineTransform(rotationAngle: .pi / 2) :  CGAffineTransform(rotationAngle: -.pi / 2)
        return Button
    }()
    
    @objc func ActionNext() {
    selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
    setWeekView()
    }
    
    lazy var TopStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [PreviousButton,monthLabel,NextButton])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(10)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var SUN : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.text = "SUN".localizable
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(15.5))
        return Label
    }()
    
    lazy var MON : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.text = "MON".localizable
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(15.5))
        return Label
    }()
    
    lazy var TUE : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.text = "TUE".localizable
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(15.5))
        return Label
    }()
    
    lazy var WED : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.text = "WED".localizable
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(15.5))
        return Label
    }()
    
    lazy var THU : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.text = "THU".localizable
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(15.5))
        return Label
    }()
    
    lazy var FRI : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.text = "FRI".localizable
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(15.5))
        return Label
    }()
    
    lazy var SAT : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.text = "SAT".localizable
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(15.5))
        return Label
    }()
    
    lazy var WeekStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [SUN,MON,TUE,WED,THU,FRI,SAT])
        Stack.axis = .horizontal
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.backgroundColor = #colorLiteral(red: 0.8901693225, green: 0.9007821679, blue: 0.8833855987, alpha: 1)
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
   
    var CalendarID = "CalendarID"
    lazy var CalendarView: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = ControlX(2)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarID)
        return vc
    }()
    
    lazy var AvailableLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.3077481091, green: 0.7303144336, blue: 0.3956181407, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.backgroundColor = #colorLiteral(red: 0.3077481091, green: 0.7303144336, blue: 0.3956181407, alpha: 1)
        View.TextLabel = "Available".localizable
        View.IconImage.setImage(UIImage(named: ""), for: .normal)
        View.IconImage.layer.cornerRadius = ControlHeight(6)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(12))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(14))
        return View
    }()
    
    
    lazy var NotAvailableLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.3543605208, green: 0.3584228158, blue: 0.3668064475, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.backgroundColor = #colorLiteral(red: 0.3543605208, green: 0.3584228158, blue: 0.3668064475, alpha: 1)
        View.TextLabel = "Not Available".localizable
        View.IconImage.setImage(UIImage(named: ""), for: .normal)
        View.IconImage.layer.cornerRadius = ControlHeight(6)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(12))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(14))
        return View
    }()
    
    lazy var SelectedLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        View.TextLabel = "Selected".localizable
        View.IconImage.setImage(UIImage(named: ""), for: .normal)
        View.IconImage.layer.cornerRadius = ControlHeight(6)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(12))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(14))
        return View
    }()
    
    lazy var Explanation : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [AvailableLabel,NotAvailableLabel,SelectedLabel])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = #colorLiteral(red: 0.8870513439, green: 0.8870513439, blue: 0.8870513439, alpha: 1)
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var ExplanationBackground:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.8870513439, green: 0.8870513439, blue: 0.8870513439, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var BookTicket : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Book Ticket".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionBookTicket), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionBookTicket() {
    Delegate?.BookTicket(View: self)
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
                    
        addSubview(SelectDate)
        addSubview(CalendarView)
        addSubview(TopStack)
        addSubview(WeekStack)
        addSubview(ExplanationBackground)
        ExplanationBackground.addSubview(Explanation)
        addSubview(BookTicket)
        
        SelectDate.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(5)).isActive = true
        SelectDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(10)).isActive = true
        SelectDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-10)).isActive = true
        SelectDate.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
        TopStack.topAnchor.constraint(equalTo: SelectDate.bottomAnchor, constant: ControlX(10)).isActive = true
        TopStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(15)).isActive = true
        TopStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        TopStack.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
        WeekStack.topAnchor.constraint(equalTo: TopStack.bottomAnchor, constant: ControlX(15)).isActive = true
        WeekStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        WeekStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        WeekStack.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
        CalendarView.topAnchor.constraint(equalTo: WeekStack.bottomAnchor, constant: ControlX(5)).isActive = true
        CalendarView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        CalendarView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        CalendarView.heightAnchor.constraint(equalToConstant: ControlWidth(110)).isActive = true
        
        ExplanationBackground.topAnchor.constraint(equalTo: CalendarView.bottomAnchor, constant: ControlX(15)).isActive = true
        ExplanationBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(15)).isActive = true
        ExplanationBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        ExplanationBackground.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
        Explanation.topAnchor.constraint(equalTo: ExplanationBackground.topAnchor).isActive = true
        Explanation.bottomAnchor.constraint(equalTo: ExplanationBackground.bottomAnchor).isActive = true
        Explanation.leadingAnchor.constraint(equalTo: ExplanationBackground.leadingAnchor, constant: ControlX(15)).isActive = true
        Explanation.trailingAnchor.constraint(equalTo: ExplanationBackground.trailingAnchor, constant: ControlX(-15)).isActive = true
        
        BookTicket.topAnchor.constraint(equalTo: Explanation.bottomAnchor, constant: ControlX(20)).isActive = true
        BookTicket.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(15)).isActive = true
        BookTicket.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        BookTicket.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        self.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        UIView.animate(withDuration: 0.3) {self.alpha = 1}
        self.selectedDate = self.ScheduleDate.first?.startDate?.Formatter(Format: "yyyy-MM-dd") ?? Date()
        self.setWeekView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWeekView() {
                
        totalSquares.removeAll()
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextSunday) {
        totalSquares.append(PlaceSchedule(id: "", startDate: current.Formatter("yyyy-MM-dd'T'HH:mm:ss"), From: "", To: "", bookingFee: 0.0, availableTickets: 0))
            
        if totalSquares.count == 7 {
        ScheduleDate.forEach { item in
        if let Index = totalSquares.firstIndex(where: {$0.startDate?.Formatter(Format: "yyyy-MM-dd'T'HH:mm:ss").Formatter("yyyy-MM-dd") == item.startDate}) {
        totalSquares[Index].id = item.id
        totalSquares[Index].openingHoursFrom = item.openingHoursFrom
        totalSquares[Index].openingHoursTo = item.openingHoursTo
        totalSquares[Index].bookingFee = item.bookingFee
        totalSquares[Index].availableTickets = item.availableTickets
        CalendarView.reloadData()
        }
        }
        }
            
        current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        CalendarView.reloadData()
    }
    
}

extension ViewCalendar:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarID, for: indexPath) as! CalendarCell
        let date = totalSquares[indexPath.item]
        cell.layer.borderColor = #colorLiteral(red: 0.3255226314, green: 0.4381471872, blue: 0.513353169, alpha: 1)
        
        if let start = date.startDate?.Formatter() {
        cell.dayOfMonth.text = "lang".localizable == "ar" ? String(CalendarHelper().dayOfMonth(date: start)).NumAR() : String(CalendarHelper().dayOfMonth(date: start))
            
        if date.openingHoursFrom != "" || date.openingHoursTo != "" {
        cell.DateLabel.isHidden = false
        cell.DateLabel.text = "\(date.openingHoursFrom ?? "")\n\("to".localizable)\n\(date.openingHoursTo ?? "")"
        }else{
        cell.DateLabel.isHidden = true
        }
                
        if cell.DateLabel.isHidden == true {
        cell.backgroundColor = #colorLiteral(red: 0.9490196109, green: 0.9490196109, blue: 0.9490196109, alpha: 1)
        cell.layer.borderWidth = 0
        cell.dayOfMonth.textColor = #colorLiteral(red: 0.309673816, green: 0.3135932088, blue: 0.3219308257, alpha: 1)
        cell.DateLabel.textColor = .clear
        cell.dayOfMonth.backgroundColor = .clear
        }else{
        if let Id = date.startDate {
        if self.DaysSelect.contains(where: {$0.startDate == Id}) {
        cell.layer.borderWidth = 1
        cell.backgroundColor = #colorLiteral(red: 0.9999999404, green: 0.9999999404, blue: 1, alpha: 1)
        cell.DateLabel.textColor = #colorLiteral(red: 0.3255226314, green: 0.4381471872, blue: 0.513353169, alpha: 1)
        cell.dayOfMonth.textColor = #colorLiteral(red: 0.9763539433, green: 0.9803349376, blue: 0.9845203757, alpha: 1)
        cell.dayOfMonth.backgroundColor = #colorLiteral(red: 0.3255226314, green: 0.4381471872, blue: 0.513353169, alpha: 1)
        }else{
        cell.layer.borderWidth = 0
        cell.backgroundColor = #colorLiteral(red: 0.9999999404, green: 0.9999999404, blue: 1, alpha: 1)
        cell.DateLabel.textColor = #colorLiteral(red: 0.8782589436, green: 0.8865231872, blue: 0.8741149902, alpha: 1)
        cell.dayOfMonth.textColor = #colorLiteral(red: 0.2619138956, green: 0.703568399, blue: 0.3407951593, alpha: 1)
        cell.dayOfMonth.backgroundColor = .clear
        }
        }
        }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if totalSquares[indexPath.item].openingHoursFrom != "" || totalSquares[indexPath.item].openingHoursTo != "" {
        if let Cell = CalendarView.cellForItem(at: indexPath) as? CalendarCell {
        guard let Id = totalSquares[indexPath.item].startDate else {return}
        if self.DaysSelect.contains(where: {$0.startDate == Id}) {
        if let index = self.DaysSelect.firstIndex(where: {$0.startDate == Id}) {
        DaysSelect.remove(at: index)
        CalendarView.reloadItems(at: [indexPath])
        }
        }else{
        DaysSelect.append(totalSquares[indexPath.item])
        CalendarView.reloadItems(at: [indexPath])
        }
        
        UIView.animate(withDuration: 0.3, animations: {
        Cell.transform = Cell.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
        UIView.animate(withDuration: 0.3, animations: {
        Cell.transform = .identity
        })
        })
        }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width) / 7
        return CGSize(width: width, height: collectionView.frame.height)
    }
}

class CalendarCell: UICollectionViewCell {
    
    
    lazy var dayOfMonth : UILabel = {
        let Label = UILabel()
        Label.clipsToBounds = true
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(14))
        return Label
    }()
    
    lazy var DateLabel : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 3
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(12))
        return Label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dayOfMonth)
        addSubview(DateLabel)
        
        dayOfMonth.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(10)).isActive = true
        dayOfMonth.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dayOfMonth.widthAnchor.constraint(equalToConstant: ControlWidth(34)).isActive = true
        dayOfMonth.heightAnchor.constraint(equalToConstant: ControlWidth(34)).isActive = true
        dayOfMonth.layer.cornerRadius = ControlWidth(17)
        
        DateLabel.topAnchor.constraint(equalTo: dayOfMonth.bottomAnchor, constant: ControlX(5)).isActive = true
        DateLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        DateLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        DateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-5)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
