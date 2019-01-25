//
//  RoundStatus.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 06/01/2019.
//  Copyright © 2019 Amin Benarieb. All rights reserved.
//

import ObjectMapper

struct RoundStatus: Equatable {
    enum Status: String {
        case waiting
        case playing
        case finished
    }
    
    let identifier: String
    let status: Status
    init(identifier: String, status: Status) {
        self.identifier = identifier
        self.status = status
    }
    
}


// MARK: ObjectMapper

extension RoundStatus: ImmutableMappable {

    init(map: Map) throws {
        self.identifier = try map.value("identifier")
        self.status = try map.value("status", using: EnumTransform<RoundStatus.Status>())
    }
}

// MARK: Diffable

extension RoundStatus: Diffable {
    var diffIdentifier: String {
        return "\(String(describing: type(of: self)))_\(self.identifier)"
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? RoundStatus else { return false }
        return self == object
    }
}
