//
//  BrushRecordView.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/21/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import UIKit
import CoreData

class BrushRecordView: UIView {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var indexPath: IndexPath?
    
    @IBAction func edit(_ sender: Any) {
        guard let indexPath = self.indexPath else { return }
        let data = ["indexPath" : indexPath] as [String : Any]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "editBrushRecord"), object: nil, userInfo: data)
    }
    
}
