//
//  Game.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import SwiftyJSON

struct Game {
    struct Summary {
        typealias UserGameInfo = (user: User, score: Int)
        let identifier: String
        let userInfo: UserGameInfo
        let partnerInfo: UserGameInfo
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
    
    var identifier: String!
    var user: User!
    var partner: User!
    var rounds: [Round]!
    var startDate: Date?
    var endDate: Date?
    var status: Status
    
    var summary: Summary {
        let userScore = self.rounds.reduce(0) { (result, round) -> Int in
            return result + round.roundUserInfo.score
        }
        let partnerScore = self.rounds.reduce(0) { (result, round) -> Int in
            return result + round.roundPartnerInfo.score
        }
        return Summary(identifier: self.identifier,
                       userInfo: (user: self.user, score: userScore),
                       partnerInfo: (user: self.partner, score: partnerScore))
    }
}

// JSON Decoding

extension Game {
    
    init(dict: [String: AnyObject]) {
        
    }
    
}

// Diffable

extension Game: Diffable, Equatable {
    
    var diffIdentifier: String {
        return self.identifier
    }
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.user == rhs.user &&
            lhs.partner == rhs.partner &&
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
        return lhs.identifier == rhs.identifier && lhs.userInfo == rhs.userInfo &&
            lhs.partnerInfo == rhs.partnerInfo;
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
