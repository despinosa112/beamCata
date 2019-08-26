//
//  MemberRecordTest.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/23/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import XCTest
@testable import Beam

class MemberRecordTest: XCTestCase {

    var memberRecord: MemberRecord!
    var sampleEffectiveDate: Date!
    
    override func setUp() {
        super.setUp()
        setupData()
    }
    
    
    func setupData(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let testDate = dateFormatter.date(from: "1989-05-08")
        
        let memberRecord = MemberRecord(id: 0, primary_insured_id: nil, name: nil, effective_date: "1989-05-08", terminated_at: nil, shipping_address: "793 Alexandria Colony Ct", shipping_city: "Columbus", shipping_state: "Ohio", shipping_zip_code: "43215")
        
        self.memberRecord = memberRecord
        self.sampleEffectiveDate = testDate
    }
        
    func testEffectiveDate(){
        let expectedEffectiveDate = self.sampleEffectiveDate
        let actualExpectedDate = self.memberRecord.effectiveDate!
        XCTAssertEqual(expectedEffectiveDate, actualExpectedDate)
    }
}
