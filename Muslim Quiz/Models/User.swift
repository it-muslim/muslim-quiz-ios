//
//  User.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import ObjectMapper

struct User: Equatable {
    let identifier: String
    let name: String?
    let email: String
    let avatarUrl: String?
    let online: Bool?
    let level: String
    let score: Int
    
    var fullName: String {
        return self.name ?? self.email
    }
}


// MARK: JSON Decoding

extension User: ImmutableMappable {
    
    init(map: Map) throws {
        self.identifier = try map.value("identifier")
        self.name = try? map.value("name")
        self.email = try map.value("email")
        self.avatarUrl = try? map.value("avatarUrl")
        self.online = try? map.value("online")
        self.level = try map.value("level")
        self.score = try map.value("score")
    }
    
}

// MARK: Diffable

extension User: Diffable {
    var diffIdentifier: String {
        return self.identifier
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? User else { return false }
        return self == object
    }
    
}
