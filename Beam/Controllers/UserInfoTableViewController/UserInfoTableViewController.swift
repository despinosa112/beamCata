//
//  UserInfoTableViewController.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/21/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//
//https://stackoverflow.com/questions/31964941/swift-how-to-make-custom-header-for-uitableview

import UIKit
import CoreData

class UserInfoTableViewController: UITableViewController {
    
    var memberRecordViewModel: MemberRecordViewModel? {
        didSet {
            reload()
        }
    }
    
    var brushRecords = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setMemberRecord()
        addObservers(observerNames: ["saveBrushRecord", "editBrushRecord", "addBrushRecord"])
        self.tableView.register(UserInfoCell.self, forCellReuseIdentifier: "cellId")
        self.tableView.register(UserInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: "headerView")
    }
    
    func setupNav(){
        self.title = "User Info"
    }
    
    func setMemberRecord(){
        MemberRecordsService.fetchMostRecentMemberRecord { (memberRecord) in
            self.memberRecordViewModel = MemberRecordViewModel(withMemberRecord: memberRecord!)
        }
    }
    
    @objc func handleAddBrushRecord(){
        presentBrushRecordModalControllerWith(brushRecord: nil, indexPath: nil)
    }
    
    func edit(_ brushRecord: BrushRecord, indexPath: IndexPath){
        presentBrushRecordModalControllerWith(brushRecord: brushRecord, indexPath: indexPath)
    }
    
    func presentBrushRecordModalControllerWith(brushRecord: BrushRecord?, indexPath: IndexPath?){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let brushRecordModalController: BrushRecordModalController = storyboard.instantiateViewController(withIdentifier: "brushRecordModalController") as! BrushRecordModalController
        if let brushRecord = brushRecord {
            brushRecordModalController.brushRecordViewModel = BrushRecordViewModel(withBrushRecord: brushRecord)
            brushRecordModalController.isExistingBrushRecord = true
        }
        if let indexPath = indexPath {
            brushRecordModalController.indexPath = indexPath
        }
        self.present(brushRecordModalController, animated: true, completion: nil)
    }
    
    
    
    func add(_ brushRecord: BrushRecord){
        CoreService.save(brushRecord)
        reload()
    }
    
    func reload(){
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let sortDescriptors = [sortDescriptor]
        CoreService.fetch(xCObjectName: "BrushRecord", predicate: nil, sortDescriptors: sortDescriptors) { (brushRecords) in
            if brushRecords == nil { self.brushRecords = [NSManagedObject](); self.tableView.reloadData(); return }
            self.brushRecords = brushRecords!
            self.tableView.reloadData()
        }
    }
    
    override func didObserveNotification(notification: NSNotification) {
        switch notification.name.rawValue {
        case "saveBrushRecord":
            self.handleSaveBrushRecordNotification(notification: notification)
        case "editBrushRecord":
            self.handleEditBrushRecordNotification(notification: notification)
        case "addBrushRecord":
            self.handleAddBrushRecord()
        default:
            print("Error: Unknown notification name")
        }
    }
    
    @objc func handleSaveBrushRecordNotification(notification: NSNotification){
        guard let brushRecord = notification.userInfo?["brushRecord"] as? BrushRecord else { return }
        guard let isExistingBrushRecord = notification.userInfo?["isExistingBrushRecord"] as? Bool else { return }
        if isExistingBrushRecord {
            saveExistingBrushRecord(notification: notification, brushRecord: brushRecord)
        } else {
            self.add(brushRecord)
        }
    }
    
    func saveExistingBrushRecord(notification: NSNotification, brushRecord: BrushRecord){
        guard let indexPath = notification.userInfo?["indexPath"] as? IndexPath else { return }
        self.brushRecords[indexPath.item] = brushRecord
        CoreService.save(brushRecord)
        reload()
    }
    
    
    @objc func handleEditBrushRecordNotification(notification: NSNotification){
        guard let indexPath = notification.userInfo?["indexPath"] as? IndexPath else { return }
        if brushRecords.count < indexPath.item { return }
        guard let brushRecord = self.brushRecords[indexPath.item] as? BrushRecord else { return }
        edit(brushRecord, indexPath: indexPath)
    }
    
    func presentDeleteBrushRecordAlert(indexPath: IndexPath){
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            //
        }
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            let brushRecordToRemove = self.brushRecords[indexPath.item]
            CoreService.delete(xCObject: brushRecordToRemove)
            self.reload()
        }
        self.presentAlertWith(title: "Delete?", message: "Are you sure you want to delete this brush record?", actions: [cancel, delete])
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    


}

//TableViewFunctions
extension UserInfoTableViewController {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brushRecords.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView" ) as! UserInfoHeaderView
        headerView.isUserInteractionEnabled = true
        headerView.memberInfoView?.nameLabel.text = memberRecordViewModel?.name
        headerView.memberInfoView?.addressLine1Label.text = memberRecordViewModel?.shippingAddressLine1
        headerView.memberInfoView?.addressLine2Label.text = memberRecordViewModel?.shippingAddressLine2
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 420
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! UserInfoCell
        let brushRecordViewModel = BrushRecordViewModel(withBrushRecord: self.brushRecords[indexPath.item] as! BrushRecord)
        cell.brushRecordView?.indexPath = indexPath
        cell.brushRecordView?.dateLabel.text = brushRecordViewModel.dateString
        cell.brushRecordView?.timeLabel.text = brushRecordViewModel.durationStringMin
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.presentDeleteBrushRecordAlert(indexPath: indexPath)
        }
    }
    

}
