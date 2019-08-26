//
//  MemberRecordViewModelTest.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/28/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import XCTest
@testable import Beam


class MemberRecordViewModelTest: XCTestCase {
    
    var memberRecordViewModel: MemberRecordViewModel!
    var emptyMemberRecordViewModel: MemberRecordViewModel!

    override func setUp() {
        super.setUp()
        setupData()
    }
    
    func setupData(){
        let memberRecord = MemberRecord(id: 10, primary_insured_id: nil, name: "Dan Espinosa", effective_date: nil, terminated_at: nil, shipping_address: "793 Alexandria Colony Ct.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let memberRecordViewModel = MemberRecordViewModel(withMemberRecord: memberRecord)
        self.memberRecordViewModel = memberRecordViewModel
        
        
        let emptyMemberRecord = MemberRecord(id: 10, primary_insured_id: nil, name: nil, effective_date: nil, terminated_at: nil, shipping_address: nil, shipping_city: nil, shipping_state: nil, shipping_zip_code: nil)
        let emptyMemberRecordViewModel = MemberRecordViewModel(withMemberRecord: emptyMemberRecord)
        self.emptyMemberRecordViewModel = emptyMemberRecordViewModel
        
    }
    
    func testMemberRecordViewModelInitializesWithMemberRecord(){
        let expectedMemberRecord = MemberRecord(id: 10, primary_insured_id: nil, name: "Dan Espinosa", effective_date: nil, terminated_at: nil, shipping_address: "793 Alexandria Colony Ct.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let actualMemberRecord = self.memberRecordViewModel.memberRecord
        XCTAssertEqual(expectedMemberRecord, actualMemberRecord)
    }
    
    func testNameWhenNameHasValue(){
        let expectedName = "Dan Espinosa"
        let actualName = self.memberRecordViewModel.name
        XCTAssertEqual(expectedName, actualName)
    }
    
    func testNameWhenNameHasNilValue(){
        let expectedName = ""
        let actualName = self.emptyMemberRecordViewModel.name
        XCTAssertEqual(expectedName, actualName)
    }
    
    func testShippingAddressLine1WhenHasValue(){
        let expectedAddressLine1 = "793 Alexandria Colony Ct."
        let actualAddressLine1 = self.memberRecordViewModel.shippingAddressLine1
        XCTAssertEqual(expectedAddressLine1, actualAddressLine1)
    }
    
    func testShippingAddressLine1WhenHasNilValue(){
        let expectedAddressLine1 = ""
        let actualAddressLine1 = self.emptyMemberRecordViewModel.shippingAddressLine1
        XCTAssertEqual(expectedAddressLine1, actualAddressLine1)
    }
    
    func testShippingAddressLine2WhenHasValue(){
        let expectedAddressLine2 = "Columbus, OH, 43215"
        let actualAddressLine2 = self.memberRecordViewModel.shippingAddressLine2
        XCTAssertEqual(expectedAddressLine2, actualAddressLine2)
    }
    
    func testShippingAddressLine2WhenHasNilValue(){
        let expectedAddressLine2 = ", , "
        let actualAddressLine2 = self.emptyMemberRecordViewModel.shippingAddressLine2
        XCTAssertEqual(expectedAddressLine2, actualAddressLine2)
    }
    
    
}
