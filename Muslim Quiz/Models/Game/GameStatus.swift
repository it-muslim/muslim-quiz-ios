//
//  GameStatus.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 06/01/2019.
//  Copyright © 2019 Amin Benarieb. All rights reserved.
//

import ObjectMapper

struct GameStatus: Equatable {
    enum Status: String {
        case waiting
        case playing
        case finished
        case rejected
    }
    
    let identifier: String
    let status: Status
}

// MARK: JSON Decoding

extension GameStatus: ImmutableMappable {
    
    init(map: Map) throws {
        self.identifier = try map.value("identifier")
        self.status = try map.value("status", using: EnumTransform<GameStatus.Status>())
    }
    
}

// MARK: Diffable

extension GameStatus: Diffable {
    
    var diffIdentifier: String {
        return "\(String(describing: type(of: self)))_\(self.identifier)"
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? GameStatus else { return false }
        return self == object
    }
    
}
