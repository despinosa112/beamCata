//
//  MemberInfoViewTest.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/29/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//
import XCTest
@testable import Beam

class MemberInfoViewTest: XCTestCase {
    
    var memberInfoView: MemberInfoView!
    
    override func setUp() {
        super.setUp()
        setupData()
    }
    
    func setupData(){
        let memberInfoView: MemberInfoView = XibHelper.loadXIB(named: "MemberInfoView", type: MemberInfoView())!
        self.memberInfoView = memberInfoView
        
    }
    
    func testAddSendsNotfication(){
        expectation(forNotification: Notification.Name(rawValue: "addBrushRecord"), object: nil, handler: nil)
        self.memberInfoView.add(UIButton())
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
