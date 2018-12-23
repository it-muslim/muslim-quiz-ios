//
//  User.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation

struct User {
    let identifier: String
    let name: String
    let avatarUrl: String?
    let online: Bool?
    let level: String
    let score: Int
}

extension User: Diffable, Equatable {
    var diffIdentifier: String {
        return self.identifier
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name &&
            lhs.avatarUrl == rhs.avatarUrl &&
            lhs.online == rhs.online &&
            lhs.level == rhs.level &&
            lhs.score == rhs.score;
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? User else { return false }
        return self == object
    }
    
}
