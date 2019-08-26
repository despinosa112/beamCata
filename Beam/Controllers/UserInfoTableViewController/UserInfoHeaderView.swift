//
//  UserInfoHeaderView.swift
//  Beam
//
//  Created by Daniel Espinosa on 7/21/19.
//  Copyright © 2019 Daniel Espinosa. All rights reserved.
//

import UIKit

class UserInfoHeaderView: UITableViewHeaderFooterView {


    var memberInfoView: MemberInfoView?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layoutMemberInfoView()
    }
    
    func layoutMemberInfoView(){
        let memberInfoView: MemberInfoView = XibHelper.loadXIB(named: "MemberInfoView", type: MemberInfoView())!
        self.memberInfoView = memberInfoView
        self.addSubview(memberInfoView)
        memberInfoView.style()
        memberInfoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        memberInfoView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        memberInfoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        memberInfoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
