//
//  BrushRecordModalControllerTest.swift
//  BeamTests
//
//  Created by Daniel Espinosa on 7/28/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import XCTest
@testable import Beam

class BrushRecordModalControllerTest: XCTestCase {
    
    var brushRecordModalController: BrushRecordModalController?
    var brushRecordViewModel: BrushRecordViewModel?
    
    
    override func setUp() {
        super.setUp()
        setupData()
    }
    
    func setupData(){
        let brushRecordModalController = BrushRecordModalController()
        brushRecordModalController.layoutModal()
        brushRecordModalController.setData()

        self.brushRecordModalController = brushRecordModalController
        
        let brushRecordViewModel = brushRecordModalController.newBrushRecordViewModel()
        self.brushRecordViewModel = brushRecordViewModel
    }
    
    func testLayoutModalSetsBrushRecordModalView(){
        let actualBrushRecordModalView = self.brushRecordModalController?.brushRecordModalView
        if actualBrushRecordModalView == nil {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
        
    }
    
    func testNewBrushRecordViewModelCreatesBrushRecordViewModel(){
        let actualBrushRecordViewModel = self.brushRecordViewModel
        if actualBrushRecordViewModel == nil {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
    
    func testSetDataSetsBrushRecordViewMode(){
        let actualBrushRecordViewModel = self.brushRecordModalController?.brushRecordViewModel
        if actualBrushRecordViewModel == nil {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
    
    func testSetDataSetsDateTextField(){
        guard let expectedDateTextFieldText = self.brushRecordModalController?.brushRecordViewModel?.dateString else { XCTAssert(false); return}
        guard let actualDateTextFieldText = self.brushRecordModalController?.brushRecordModalView?.dateTextField.text else { XCTAssert(false); return}
        XCTAssertEqual(expectedDateTextFieldText, actualDateTextFieldText)

    }
    
    func testSetDataSetsDurationTextField(){
        let expectedDurationTextFieldText = "0"
        guard let actualDurationTextFieldText = self.brushRecordModalController?.brushRecordModalView?.durationTextField.text else { XCTAssert(false); return}
        XCTAssertEqual(expectedDurationTextFieldText, actualDurationTextFieldText)
    }
    
    func testDidSaveSendsNotification(){
        expectation(forNotification: Notification.Name(rawValue: "saveBrushRecord"), object: nil, handler: nil)
        self.brushRecordModalController?.didSave(brushRecordModalView: self.brushRecordModalController!.brushRecordModalView!)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    override func tearDown() {
        CoreService.fetch(xCObjectName: "BrushRecord", predicate: nil, sortDescriptors: nil) { (brushRecords) in
            if brushRecords != nil {
                for brushRecord in brushRecords! {
                    CoreService.delete(xCObject: brushRecord)
                }
            }
        }
    }
}
