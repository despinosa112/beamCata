//
//  MemberRecord.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/20/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import Foundation

struct MemberRecord: Decodable, Equatable {
    //JSON Variables
    let id: Int
    let primary_insured_id: Int?
    let name: String?
    let effective_date: String?
    let terminated_at: String?
    let shipping_address: String?
    let shipping_city: String?
    let shipping_state: String?
    let shipping_zip_code: String?
    
    //Computed Properties
    var effectiveDate: Date? {
        guard let effectiveDateString = effective_date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let date = dateFormatter.date(from: effectiveDateString)
        return date
    }

}
