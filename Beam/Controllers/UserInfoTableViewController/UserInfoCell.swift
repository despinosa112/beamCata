//
//  UserInfoCell.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/21/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import UIKit
class UserInfoCell: UITableViewCell {
    
    var brushRecordView: BrushRecordView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutBrushRecordView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layoutBrushRecordView(){
        let brushRecordView: BrushRecordView = XibHelper.loadXIB(named: "BrushRecordView", type: BrushRecordView())!
        self.brushRecordView = brushRecordView
        self.addSubview(brushRecordView)
        brushRecordView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        brushRecordView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        brushRecordView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        brushRecordView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }

}

