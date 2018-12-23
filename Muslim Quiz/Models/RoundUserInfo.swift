//
//  Round.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation

struct RoundUserInfo {
    enum Status: Equatable {
        case answers([Bool])
        case text(String)
    }
    let user: User
    let score: Int
    let status: Status?
}

extension RoundUserInfo: Diffable, Equatable {
    var diffIdentifier: String {
        return self.user.identifier
    }
    
    static func == (lhs: RoundUserInfo, rhs: RoundUserInfo) -> Bool {
        return lhs.user == rhs.user &&
            lhs.score == rhs.score &&
            lhs.status == rhs.status;
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? RoundUserInfo else { return false }
        return self == object
    }
}
