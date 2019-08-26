//
//  UserInfoHeaderViewTest.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/28/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import XCTest
@testable import Beam

class UserInfoHeaderViewTest: XCTestCase {

    var userInfoHeaderView: UserInfoHeaderView!
    
    override func setUp() {
        super.setUp()
        setupData()
    }
    
    func setupData(){
        let userInfoHeaderView = UserInfoHeaderView()
        self.userInfoHeaderView = userInfoHeaderView
    }
    
    
    func testDoesLayoutMemberInfoView(){
        if userInfoHeaderView.memberInfoView == nil {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
    
}
