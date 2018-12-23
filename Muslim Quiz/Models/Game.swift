//
//  Game.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import ObjectMapper

struct Game {
    struct Summary {
        let identifier: String
        let userInfos: [GameUserInfo]
    }
    struct Status {
        enum Status: Equatable {
            case waiting
            case inProgress
            case finished(Date)
            case giveUp(Date?)
        }
        
        let identifier: String
        let status: Status
    }
    
    let identifier: String
    let userInfos: [GameUserInfo]
    let rounds: [Round]
    let startDate: Date?
    let endDate: Date?
    let status: Status
    
    var summary: Summary {
        return Summary(identifier: self.identifier,
                       userInfos: self.userInfos)
    }
}

// JSON Decoding

extension Game: ImmutableMappable {
    
    init(map: Map) throws {
        
        self.identifier = try map.value("identifier")
        self.userInfos = try map.value("users") //
        self.rounds = try map.value("rounds") //
        self.startDate = try? map.value("startDate", using: DateTransform()) //
        self.endDate = try? map.value("endDate", using: DateTransform()) //
        self.status = try map.value("status") //
    }
    
}

// Diffable

extension Game: Diffable, Equatable {
    
    var diffIdentifier: String {
        return self.identifier
    }
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.userInfos == rhs.userInfos &&
            lhs.rounds == rhs.rounds &&
            lhs.startDate == rhs.startDate &&
            lhs.endDate == rhs.endDate
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Game else { return false }
        return self == object
    }
}

extension Game.Summary: Diffable, Equatable {
    
    var diffIdentifier: String {
        return "\(String(describing: type(of: self)))_\(self.identifier)"
    }
    
    static func == (lhs: Game.Summary, rhs: Game.Summary) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.userInfos == rhs.userInfos;
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Game.Summary else { return false }
        return self == object
    }
}

extension Game.Status: Diffable, Equatable {
    
    var diffIdentifier: String {
        return "\(String(describing: type(of: self)))_\(self.identifier)"
    }
    
    static func == (lhs: Game.Status, rhs: Game.Status) -> Bool {
        return lhs.status == rhs.status
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Game.Status else { return false }
        return self == object
    }
    
}
