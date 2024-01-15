//
//  ProfileCell.swift
//  LLDC
//
//  Created by Emojiios on 30/03/2022.
//

import UIKit

class ProfileCell: UICollectionViewCell {
 
    lazy var LeftLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var RightLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(16))
        return Label
    }()
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LeftLabel,RightLabel])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(2)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = #colorLiteral(red: 0.9558447003, green: 0.9558447003, blue: 0.9558447003, alpha: 1)
        return Stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9558447003, green: 0.9558447003, blue: 0.9558447003, alpha: 1)
        
        addSubview(Stack)
        Stack.frame = CGRect(x: ControlX(15), y: 0, width: self.frame.width - ControlX(30), height: self.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
