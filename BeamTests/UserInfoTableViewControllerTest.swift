//
//  UserInfoTableViewControllerTest.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/28/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import XCTest
import CoreData
@testable import Beam


class UserInfoTableViewControllerTest: XCTestCase {
    
    var userInfoTableViewController: UserInfoTableViewController!
    
    override func setUp() {
        super.setUp()
        setupData()
    }
    
    func setupData(){
        let userInfoTableViewController = UserInfoTableViewController()
        userInfoTableViewController.setupNav()
        self.userInfoTableViewController = userInfoTableViewController
    }
    
    func testSetsTitle(){
        let expectedTitle = "User Info"
        let actualTitle = userInfoTableViewController.title!
        XCTAssertEqual(expectedTitle, actualTitle)
    }
    
    func testReload(){
        //1. Clear Data
        CoreService.fetch(xCObjectName: "BrushRecord", predicate: nil, sortDescriptors: nil) { (brushRecords) in
            if brushRecords == nil { return }
            for brushRecord in brushRecords! {
                CoreService.delete(xCObject: brushRecord)
            }
        }
        
        
        //2. Create And save data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let sampleDate = dateFormatter.date(from: "1989-05-08")
        let data = ["Date" : sampleDate!] as [String : Any]
        let brushRecord = CoreService.create(xCObjectName: "BrushRecord", data: data)
        CoreService.save(brushRecord!)
        
        //3. Call Reload
        self.userInfoTableViewController.reload()
        
        //4.Validate brushRecords
        let actualBrushRecords = self.userInfoTableViewController.brushRecords
        let expectedBrushRecords = [brushRecord]
        
        XCTAssertEqual(actualBrushRecords, expectedBrushRecords)
    }
    
    override func tearDown() {
        CoreService.fetch(xCObjectName: "BrushRecord", predicate: nil, sortDescriptors: nil) { (brushRecords) in
            if brushRecords != nil {
                for brushRecord in brushRecords! {
                    CoreService.delete(xCObject: brushRecord)
                }
            }
        }
    }
    
}
