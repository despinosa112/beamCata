//
//  EditBrushRecordModalController.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/21/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import UIKit
import CoreData

class BrushRecordModalController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    var brushRecordModalView: BrushRecordModalView?
    
    var brushRecordViewModel: BrushRecordViewModel?
    var isExistingBrushRecord = false
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAlpha()
        layoutModal()
        setData()
    }
    
    func setAlpha(){
        if backgroundView != nil {
            self.backgroundView.alpha = 0.5
        }
    }
    
    
    func layoutModal(){
        let brushRecordModalView: BrushRecordModalView = XibHelper.loadXIB(named: "BrushRecordModalView", type: BrushRecordModalView())!
        self.brushRecordModalView = brushRecordModalView
        self.view.addSubview(brushRecordModalView)
        
        brushRecordModalView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        brushRecordModalView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -100).isActive = true
        brushRecordModalView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        brushRecordModalView.heightAnchor.constraint(equalToConstant: 250).isActive = true

        brushRecordModalView.delegate = self
        brushRecordModalView.layer.cornerRadius = 8
        brushRecordModalView.layer.masksToBounds = true
    }
    
    func newBrushRecordViewModel() -> BrushRecordViewModel {
        let data = ["Date" : Date()] as [String : Any]
        let brushRecord = CoreService.create(xCObjectName: "BrushRecord", data: data) as! BrushRecord
        return BrushRecordViewModel(withBrushRecord: brushRecord)
    }
    
    func setData(){
        if brushRecordViewModel == nil {
            self.brushRecordViewModel = newBrushRecordViewModel()
        }
        self.brushRecordModalView!.dateTextField.text = self.brushRecordViewModel!.dateString
        self.brushRecordModalView!.durationTextField.text = self.brushRecordViewModel!.durationNumberString
    }
    
    
}

extension BrushRecordModalController: BrushRecordModalViewDelegate {
    
    func didSave(brushRecordModalView: BrushRecordModalView) {
        if self.brushRecordViewModel == nil { return }
        if let durationDouble = Double(self.brushRecordModalView?.durationTextField.text ?? "0") {
            if let durationInt16 = Int16(exactly: durationDouble) {
                brushRecordViewModel!.brushRecord.duration = durationInt16
            }
        }
        if let dateString = self.brushRecordModalView?.dateTextField.text {
            self.brushRecordViewModel!.setDate(dateString: dateString)
        }
        sendBrushRecordNotification()
        self.dismiss(animated: true, completion: nil)

    }
    
    func sendBrushRecordNotification(){
        guard let  brushRecord = self.brushRecordViewModel?.brushRecord else { return }
        let data = ["brushRecord" : brushRecord, "isExistingBrushRecord" : self.isExistingBrushRecord, "indexPath": self.indexPath] as [String : Any]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "saveBrushRecord"), object: nil, userInfo: data)
    }
    
    func didCancel(brushRecordModalView: BrushRecordModalView) {
        self.dismiss(animated: true, completion: nil)
    }
}

