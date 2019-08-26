//
//  BrushRecordViewModel.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/26/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import Foundation

class BrushRecordViewModel {
    
    var brushRecord: BrushRecord
    
    init(withBrushRecord brushRecord: BrushRecord) {
        self.brushRecord = brushRecord
    }
    
    var dateString: String {
        guard let date = brushRecord.date else { return "n/a" }
        let format = DateFormatter()
        format.dateFormat = "MM/dd HH:mm"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    var dateSeconds: String {
        guard let date = brushRecord.date else { return "n/a" }
        let format = DateFormatter()
        format.dateFormat = "ss"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    var yearString: String {
        guard let date = brushRecord.date else { return "n/a" }
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    var durationStringMin: String {
        let duration = brushRecord.duration
        return "\(duration) min"
    }
    
    var durationNumberString: String {
        let duration = brushRecord.duration
        return "\(duration)"
    }
    
    func setDate(dateString: String){
        let dateStringWithSeconds = "\(self.yearString)/\(dateString):\(dateSeconds)"
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd HH:mm:ss"
        guard let newDate = format.date(from: dateStringWithSeconds) else { return }
        brushRecord.date = newDate
    }
    
}
