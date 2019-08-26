//
//  BrushRecordViewTest.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/29/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import XCTest
@testable import Beam

class BrushRecordViewTest: XCTestCase {
    
    var brushRecordView: BrushRecordView!

    override func setUp() {
        super.setUp()
        setupData()
    }
    
    func setupData(){
        let brushRecordView: BrushRecordView = XibHelper.loadXIB(named: "BrushRecordView", type: BrushRecordView())!
        brushRecordView.indexPath = IndexPath(row: 0, section: 0)
        self.brushRecordView = brushRecordView

    }
    
    func testEditSendsNotification(){
        expectation(forNotification: Notification.Name(rawValue: "editBrushRecord"), object: nil, handler: nil)
        self.brushRecordView.edit(UIButton())
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}

