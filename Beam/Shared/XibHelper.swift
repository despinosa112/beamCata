//
//  XibHelper.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/21/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import UIKit

class XibHelper: NSObject {

    static func loadXIB<T: UIView>(named: String, type: T) -> T? {
        if let view = Bundle.main.loadNibNamed(named, owner: self, options: nil)?.first as? T{
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        } else {
            return nil
        }
    }
    
}
