//
//  File.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation

struct GameUserInfo {
    enum Status: Equatable {
        case answers([Bool])
        case text(String)
    }
    let user: User
    let initator: Bool
    let score: Int
}

extension GameUserInfo: Diffable, Equatable {
    var diffIdentifier: String {
        return self.user.identifier
    }
    
    static func == (lhs: GameUserInfo, rhs: GameUserInfo) -> Bool {
        return lhs.user == rhs.user &&
            lhs.score == rhs.score &&
            lhs.initator == rhs.initator;
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? GameUserInfo else { return false }
        return self == object
    }
}
