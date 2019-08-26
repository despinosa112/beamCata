//
//  CoreServiceTest.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/28/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import XCTest
import CoreData
@testable import Beam


//Note: these tests will delete any XCbrushRecord data on a device
class CoreServiceTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        setupData()
    }
    
    func setupData(){
        clearBrushRecordData()
    }
    
    override func tearDown() {
        clearBrushRecordData()
    }
    
    func clearBrushRecordData(){
        CoreService.fetch(xCObjectName: "BrushRecord", predicate: nil, sortDescriptors: nil) { (brushRecords) in
            if brushRecords != nil {
                for brushRecord in brushRecords! {
                    CoreService.delete(xCObject: brushRecord)
                }
            }
        }
    }
    
    func testCreate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let sampleDate = dateFormatter.date(from: "1989-05-08")
        let data = ["Date" : sampleDate!] as [String : Any]
        let brushRecord = CoreService.create(xCObjectName: "BrushRecord", data: data)
        
        if brushRecord == nil {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
    
    func testSaveAndFetch(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let sampleDate = dateFormatter.date(from: "1989-05-08")
        let data = ["Date" : sampleDate!] as [String : Any]
        let brushRecord = CoreService.create(xCObjectName: "BrushRecord", data: data)
        
        
        CoreService.save(brushRecord!)
        CoreService.fetch(xCObjectName: "BrushRecord", predicate: nil, sortDescriptors: nil) { (brushRecords) in
            
            let actualBrushRecord = brushRecords![0]
            let expectedBrushRrecord = brushRecord
            XCTAssertEqual(actualBrushRecord, expectedBrushRrecord)
    
        }
    }
    
    func testDelete(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let sampleDate = dateFormatter.date(from: "1989-05-08")
        let data = ["Date" : sampleDate!] as [String : Any]
        let brushRecord = CoreService.create(xCObjectName: "BrushRecord", data: data)
        CoreService.save(brushRecord!)
        CoreService.delete(xCObject: brushRecord!)
        
        CoreService.fetch(xCObjectName: "BrushRecord", predicate: nil, sortDescriptors: nil) { (brushRecords) in
            let actualBrushRecords = brushRecords
            let expectedBrushRecords: [NSManagedObject]? = [NSManagedObject]()
            XCTAssertEqual(actualBrushRecords, expectedBrushRecords)
        }
    }
}

