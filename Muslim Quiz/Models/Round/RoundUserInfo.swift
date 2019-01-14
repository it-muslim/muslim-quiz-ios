//
//  Round.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import ObjectMapper

struct RoundUserInfo: Equatable {
    let userId: String
    let score: Int
    
    enum Status: Equatable {
        case finished([Bool])
        case giveUp
        case timeOver
    }
    
    /// Required join
    var user: User?
    let status: Status?
    
}

// MARK: JSON Decoding

extension RoundUserInfo: ImmutableMappable {

    init(map: Map) throws {
        self.userId = try map.value("identifier")
        self.score = try map.value("score")
        let giveUp: Bool? = try? map.value("giveup")
        let timeOver: Bool? = try? map.value("timeover")
        let answers: [Bool]? = try? map.value("answers")
        
        self.status = {
            if giveUp == true {
              return .giveUp
            }
            else if timeOver == true {
                return .timeOver
            }
            return .finished(answers ?? [Bool]())
        }()
    }
}

// MARK: Diffable

extension RoundUserInfo: Diffable {
    var diffIdentifier: String {
        return self.userId
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? RoundUserInfo else { return false }
        return self == object
    }
}
