//
//  UserInfoCellTest.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/28/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//


import XCTest
@testable import Beam

class UserInfoCellTest: XCTestCase {
    
    var userInfoCell: UserInfoCell!
    
    override func setUp() {
        super.setUp()
        setupData()
    }
    
    func setupData(){
        let userInfoCell = UserInfoCell()        
        self.userInfoCell = userInfoCell
    }
    
    
    func testDoesLayoutBrushRecordView(){
        if userInfoCell.brushRecordView == nil {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
    
    
}
