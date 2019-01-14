//
//  File.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import ObjectMapper

struct GameUserInfo: Equatable {
    enum Status: Equatable {
        case answers([Bool])
        case text(String)
    }
    
    let identifier: String
    let initiator: Bool
    let score: Int
    
    var user: User?
}

// MARK: JSON Decoding

extension GameUserInfo: ImmutableMappable {
    
    init(map: Map) throws {
        self.identifier = try map.value("identifier")
        self.initiator = {
            do {
                return try map.value("initiator")
            }
            catch {
                return false
            }
        }()
        self.score = try map.value("score")
    }
    
}
