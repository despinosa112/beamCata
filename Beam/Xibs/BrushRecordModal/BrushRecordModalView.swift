//
//  BrushRecordModalView.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/21/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import UIKit

protocol BrushRecordModalViewDelegate {
    func didSave(brushRecordModalView: BrushRecordModalView)
    func didCancel(brushRecordModalView: BrushRecordModalView)
}

class BrushRecordModalView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    var delegate: BrushRecordModalViewDelegate?
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.didCancel(brushRecordModalView: self)
    }
    
    @IBAction func save(_ sender: Any) {
        delegate?.didSave(brushRecordModalView: self)
    }
    
}
