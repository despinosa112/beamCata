//
//  MemberInfoView.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/21/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import UIKit

class MemberInfoView: UIView {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLine1Label: UILabel!
    @IBOutlet weak var addressLine2Label: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    
    func style(){
        addButton.layer.cornerRadius = 20
    }
    
    @IBAction func add(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "addBrushRecord"), object: nil, userInfo: nil)
    }
}
