//
//  XibHelperTest.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/28/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//


import XCTest
@testable import Beam

class XibHelperTest: XCTestCase {
    
    var brushRecordModalView: BrushRecordModalView?
    var invalidView: BrushRecordModalView?
    
    
    override func setUp() {
        super.setUp()
        setupData()
    }
    
    func setupData(){
        if let brushRecordModalView: BrushRecordModalView = XibHelper.loadXIB(named: "BrushRecordModalView", type: BrushRecordModalView()){
            self.brushRecordModalView = brushRecordModalView
        }
    }
    
    func testLoadXibLoadsSuccessfully(){
        if self.brushRecordModalView == nil {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
    
}

