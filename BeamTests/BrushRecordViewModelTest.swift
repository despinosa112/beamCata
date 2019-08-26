//
//  BrushRecordViewModelTest.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/28/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//


import XCTest
@testable import Beam

class BrushRecordViewModelTest: XCTestCase {

    
    var brushRecordViewModel: BrushRecordViewModel!
    
    override func setUp() {
        super.setUp()
        setupData()
    }
    
    func setupData(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd':'HH':'mm':'ss"
        let sampleDate = dateFormatter.date(from: "1989-05-08:12:44:22")
        let data = ["Date" : sampleDate!, "Duration": Int16(17)] as [String : Any]
        let brushRecord = CoreService.create(xCObjectName: "BrushRecord", data: data) as! BrushRecord
        let brushRecordViewModel = BrushRecordViewModel(withBrushRecord: brushRecord)
        self.brushRecordViewModel = brushRecordViewModel
        
        self.brushRecordViewModel.setDate(dateString: "05/08 11:13")
    }
    
    func testDateString(){
        let actualDateString = self.brushRecordViewModel.dateString
        let expectedDateString = "05/08 11:13"
        XCTAssertEqual(actualDateString, expectedDateString)
    }
    
    func testDateSecond(){
        let actualDateSeconds = self.brushRecordViewModel.dateSeconds
        let expectedDateSeconds = "22"
        XCTAssertEqual(actualDateSeconds, expectedDateSeconds)
    }
    
    func testDurationStringMin(){
        let actualDurationStringMin = self.brushRecordViewModel.durationStringMin
        let expectedDurationStringMin = "17 min"
        XCTAssertEqual(actualDurationStringMin, expectedDurationStringMin)
    }
    
    func testDurationNumberString(){
        let actualNumberString = self.brushRecordViewModel.durationNumberString
        let expectedNumberString = "17"
        XCTAssertEqual(actualNumberString, expectedNumberString)
    }
    
    func testYearsString(){
        let actualYearString = self.brushRecordViewModel.yearString
        let expectedYearString  = "1989"
        XCTAssertEqual(actualYearString, expectedYearString)
    }
    
    func testSetDate(){
        let actualDate = self.brushRecordViewModel.brushRecord.date!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd':'HH':'mm':'ss"
        let expectedDate = dateFormatter.date(from: "1989-05-08:11:13:22")
        XCTAssertEqual(actualDate, expectedDate!)
    }
}
