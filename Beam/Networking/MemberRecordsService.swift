//
//  MemberRecordsService.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/20/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import UIKit

class MemberRecordsService: NSObject {
    
    static func fetchMemberRecords(completion: @escaping([MemberRecord]?) -> ()){
        let urlString = "https://member-data.beam.dental/searchResults.json"
        guard let url = URL(string: urlString) else { return }
        NetworkService.fetch(url: url) { (memberRecords) in
            DispatchQueue.main.async {
                completion(memberRecords)
            }
        }
    }
    
    static func query(_ memberRecords: [MemberRecord], hasPrimaryInsuredId: Bool, hasBeenTerminated: Bool, effectiveDateDescending: Bool) -> [MemberRecord] {
        
        var queriedMemberRecords = memberRecords
        
        queriedMemberRecords = filterMemberRecords(queriedMemberRecords, hasPrimaryInsuredId: hasPrimaryInsuredId)
        queriedMemberRecords = filterMemberRecords(queriedMemberRecords, hasBeenTerminated: hasBeenTerminated)
        queriedMemberRecords = sortMemberRecords(queriedMemberRecords, effectiveDateDescending: effectiveDateDescending)
        return queriedMemberRecords
    }
    
    
    static func filterMemberRecords(_ memberRecords:[MemberRecord], hasPrimaryInsuredId: Bool) -> [MemberRecord] {
        return memberRecords.filter { (memberRecord) -> Bool in
            let memberRecordHasPrimaryInsuredId = memberRecord.primary_insured_id != nil ? true : false
            return memberRecordHasPrimaryInsuredId == hasPrimaryInsuredId ? true : false
        }
    }
    
    static func filterMemberRecords(_ memberRecords:[MemberRecord], hasBeenTerminated: Bool) -> [MemberRecord] {
        return memberRecords.filter { (memberRecord) -> Bool in
            let memberRecordHasBeenTerminated = memberRecord.terminated_at != nil ? true : false
            return memberRecordHasBeenTerminated == hasBeenTerminated ? true : false
        }
    }
    
    static func sortMemberRecords(_ memberRecords: [MemberRecord], effectiveDateDescending: Bool) -> [MemberRecord] {
        var sortingMemberRecords = memberRecords
        sortingMemberRecords = sortingMemberRecords.filter({return $0.effective_date != nil})
        if effectiveDateDescending {
            sortingMemberRecords = sortingMemberRecords.sorted(by: { $0.effectiveDate! > $1.effectiveDate! })
        } else {
            sortingMemberRecords = sortingMemberRecords.sorted(by: { $0.effectiveDate! < $1.effectiveDate! })

        }
        return sortingMemberRecords
    }
    
    //This function is getting the correct memberRecord for Remy Lebeau
    static func fetchMostRecentMemberRecord(completion: @escaping(MemberRecord?)->()){
        fetchMemberRecords { (memberRecords) in
            if memberRecords != nil {
                let queriedMembers = MemberRecordsService.query(memberRecords!, hasPrimaryInsuredId: false, hasBeenTerminated: false, effectiveDateDescending: true)
            
                if queriedMembers.count > 0 {
                    completion(queriedMembers[0])
                }
            }
        }
    }
    
    
}
