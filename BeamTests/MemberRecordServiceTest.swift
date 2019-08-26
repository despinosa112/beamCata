//
//  MemberRecordServiceTest2.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/28/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import XCTest
@testable import Beam

class MemberRecordServiceTest: XCTestCase {
    
    let memberRecordsResponse = "[\r\n  {\r\n    \"id\": 62,\r\n    \"primary_insured_id\": 249,\r\n    \"name\": \"Remy LeBeau\",\r\n    \"effective_date\": \"2019-01-01\",\r\n    \"terminated_at\": \"2019-01-01\",\r\n    \"shipping_address\": \"616 Thieves' Guild St.\",\r\n    \"shipping_city\": \"Columbus\",\r\n    \"shipping_state\": \"OH\",\r\n    \"shipping_zip_code\": \"43215\"\r\n  },\r\n  {\r\n    \"id\": 13,\r\n    \"primary_insured_id\": 0,\r\n    \"name\": \"Remy LeBeau\",\r\n    \"effective_date\": \"2018-01-01\",\r\n    \"terminated_at\": null,\r\n    \"shipping_address\": \"616 Thieves' Guild St.\",\r\n    \"shipping_city\": \"Columbus\",\r\n    \"shipping_state\": \"OH\",\r\n    \"shipping_zip_code\": \"43215\"\r\n  },\r\n  {\r\n    \"id\": 43,\r\n    \"primary_insured_id\": null,\r\n    \"name\": \"Remy LeBeau\",\r\n    \"effective_date\": \"2017-01-01\",\r\n    \"terminated_at\": null,\r\n    \"shipping_address\": \"616 Thieves' Guild St.\",\r\n    \"shipping_city\": \"Columbus\",\r\n    \"shipping_state\": \"OH\",\r\n    \"shipping_zip_code\": \"43215\"\r\n  }\r\n]"
    
    var memberRecords: [MemberRecord]!
    
    override func setUp() {
        super.setUp()
        setupData()
    }
    
    func setupData(){
        do {
            let memberRecords = try JSONDecoder().decode([MemberRecord].self, from: Data(memberRecordsResponse.utf8))
            self.memberRecords = memberRecords
        } catch {
            print("ERROR: not able to decode memberRecords")
        }
    }
    
    func testAbleToDecodeMemberRecordsResponse(){
        let memberRecord1 = MemberRecord(id: 62, primary_insured_id: 249, name: "Remy LeBeau", effective_date: "2019-01-01", terminated_at: "2019-01-01", shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let memberRecord2 = MemberRecord(id: 13, primary_insured_id: 0, name: "Remy LeBeau", effective_date: "2018-01-01", terminated_at: nil, shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let memberRecord3 = MemberRecord(id: 43, primary_insured_id: nil, name: "Remy LeBeau", effective_date: "2017-01-01", terminated_at: nil, shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        
        let expectedMemberRecords: [MemberRecord] = [memberRecord1, memberRecord2, memberRecord3]
        let actualMemberRecords = self.memberRecords!

        XCTAssertEqual(expectedMemberRecords, actualMemberRecords)

    }
    
    func testFilterHasPrimaryInsureId(){
        let memberRecord1 = MemberRecord(id: 62, primary_insured_id: 249, name: "Remy LeBeau", effective_date: "2019-01-01", terminated_at: "2019-01-01", shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let memberRecord2 = MemberRecord(id: 13, primary_insured_id: 0, name: "Remy LeBeau", effective_date: "2018-01-01", terminated_at: nil, shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        
        let expectedMemberRecords: [MemberRecord] = [memberRecord1, memberRecord2]
        let actualMembersWithPrimaryInsureId = MemberRecordsService.filterMemberRecords(self.memberRecords!, hasPrimaryInsuredId: true)
        XCTAssertEqual(expectedMemberRecords, actualMembersWithPrimaryInsureId)
    }

    
    func testFilterWithoutPrimaryInsureId(){
        let memberRecord1 = MemberRecord(id: 43, primary_insured_id: nil, name: "Remy LeBeau", effective_date: "2017-01-01", terminated_at: nil, shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let expectedMemberRecords: [MemberRecord] = [memberRecord1, ]
        let actualMemberRecords = MemberRecordsService.filterMemberRecords(self.memberRecords!, hasPrimaryInsuredId: false)
        XCTAssertEqual(expectedMemberRecords, actualMemberRecords)
    }
    
    func testFilterWithTerminationDate(){
        let memberRecord1 = MemberRecord(id: 62, primary_insured_id: 249, name: "Remy LeBeau", effective_date: "2019-01-01", terminated_at: "2019-01-01", shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let expectedMemberRecords = [memberRecord1]
        let actualMemberRecords = MemberRecordsService.filterMemberRecords(self.memberRecords!, hasBeenTerminated: true)
        XCTAssertEqual(expectedMemberRecords, actualMemberRecords)
    }
    
    func testFilterWithoutTerminationDate(){
        let memberRecord1 = MemberRecord(id: 13, primary_insured_id: 0, name: "Remy LeBeau", effective_date: "2018-01-01", terminated_at: nil, shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let memberRecord2 = MemberRecord(id: 43, primary_insured_id: nil, name: "Remy LeBeau", effective_date: "2017-01-01", terminated_at: nil, shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let expectedMemberRecords = [memberRecord1, memberRecord2]
        let actualMemberRecords = MemberRecordsService.filterMemberRecords(self.memberRecords!, hasBeenTerminated: false)
        XCTAssertEqual(expectedMemberRecords, actualMemberRecords)
    }
    
    
    
    func testSortAscending(){
        let memberRecord1 = MemberRecord(id: 62, primary_insured_id: 249, name: "Remy LeBeau", effective_date: "2019-01-01", terminated_at: "2019-01-01", shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let memberRecord2 = MemberRecord(id: 13, primary_insured_id: 0, name: "Remy LeBeau", effective_date: "2018-01-01", terminated_at: nil, shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let memberRecord3 = MemberRecord(id: 43, primary_insured_id: nil, name: "Remy LeBeau", effective_date: "2017-01-01", terminated_at: nil, shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        
        let expectedMemberRecords = [memberRecord3, memberRecord2, memberRecord1]
        let actualMemberRecords = MemberRecordsService.sortMemberRecords(self.memberRecords, effectiveDateDescending: false)
        XCTAssertEqual(expectedMemberRecords, actualMemberRecords)
    }
    
    func testSortDescending(){
        let memberRecord1 = MemberRecord(id: 62, primary_insured_id: 249, name: "Remy LeBeau", effective_date: "2019-01-01", terminated_at: "2019-01-01", shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let memberRecord2 = MemberRecord(id: 13, primary_insured_id: 0, name: "Remy LeBeau", effective_date: "2018-01-01", terminated_at: nil, shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        let memberRecord3 = MemberRecord(id: 43, primary_insured_id: nil, name: "Remy LeBeau", effective_date: "2017-01-01", terminated_at: nil, shipping_address: "616 Thieves' Guild St.", shipping_city: "Columbus", shipping_state: "OH", shipping_zip_code: "43215")
        
        let expectedMemberRecords = [memberRecord1, memberRecord2, memberRecord3]
        let actualMemberRecords = MemberRecordsService.sortMemberRecords(self.memberRecords, effectiveDateDescending: true)
        XCTAssertEqual(expectedMemberRecords, actualMemberRecords)
    }

    
}
