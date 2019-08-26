//
//  MemberInfoViewModel.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/25/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import Foundation

class MemberRecordViewModel {
    
    let memberRecord: MemberRecord
    
    init(withMemberRecord memberRecord: MemberRecord) {
        self.memberRecord = memberRecord
    }
    
    var name: String {
        return memberRecord.name != nil ? memberRecord.name! : ""
    }
    
    var shippingAddressLine1: String {
        return memberRecord.shipping_address != nil ? memberRecord.shipping_address! : ""
    }
    
    var shippingAddressLine2: String {
        let city = memberRecord.shipping_city != nil ? memberRecord.shipping_city! : ""
        let state = memberRecord.shipping_state != nil ? memberRecord.shipping_state! : ""
        let zip = memberRecord.shipping_zip_code != nil ? memberRecord.shipping_zip_code! : ""
        return "\(city), \(state), \(zip)"
    }
}
