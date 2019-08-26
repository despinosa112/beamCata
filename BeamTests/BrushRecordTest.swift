//
//  BrushRecordTest.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/23/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import XCTest
import CoreData

@testable import Beam

class BrushRecordTest: XCTestCase {
    
    var brushRecord: BrushRecord!
    var sampleDate: Date!

    override func setUp() {
        super.setUp()
        setupData()
    }

    func setupData(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let sampleDate = dateFormatter.date(from: "1989-05-08")
        self.sampleDate = sampleDate!

        let data = ["Date" : sampleDate!, "Duration" : 5] as [String : Any]
        let nsMangedObject = CoreService.create(xCObjectName: "BrushRecord", data: data)
        if let brushRecord = nsMangedObject as? BrushRecord {
            self.brushRecord = brushRecord
        }
    }
    
    func testDate(){
        let actualDate = brushRecord.date!
        let expectedDate = self.sampleDate
        XCTAssertEqual(actualDate, expectedDate)
    }
    
    func testDuration(){
        let actualDuration = brushRecord.duration
        let expectedDuration = Int16(exactly: 5.0)
        XCTAssertEqual(actualDuration, expectedDuration)
    }
}
