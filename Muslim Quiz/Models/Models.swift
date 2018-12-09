//
//  Game.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit.IGListDiffable

//TODO: Split into files

class User: Equatable {
    let identifier: String
    let name: String
    let avatarUrl: String?
    let online: Bool?
    let level: String
    let score: Int
    
    init(identifier: String,
         name: String,
         avatarUrl: String? = nil,
         online: Bool = false,
         level: String,
         score: Int) {
        self.identifier = identifier
        self.name = name
        self.avatarUrl = avatarUrl
        self.online = online
        self.level = level
        self.score = score
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name &&
            lhs.avatarUrl == rhs.avatarUrl &&
            lhs.online == rhs.online &&
            lhs.level == rhs.level &&
            lhs.score == rhs.score;
    }
}

class Game: Equatable {
    class Summary: Equatable {
        typealias UserGameInfo = (user: User, score: Int)
        let identifier: String
        let userInfo: UserGameInfo
        let partnerInfo: UserGameInfo
        
        init(identifier: String,
             userInfo: UserGameInfo,
             partnerInfo: UserGameInfo) {
            self.identifier = identifier
            self.userInfo = userInfo
            self.partnerInfo = partnerInfo
        }
        
        static func == (lhs: Summary, rhs: Summary) -> Bool {
            return lhs.identifier == rhs.identifier && lhs.userInfo == rhs.userInfo &&
                lhs.partnerInfo == rhs.partnerInfo;
        }
    }
    class Status: Equatable {
        enum Status: Equatable {
            case waiting
            case inProgress
            case finished(Date)
        }
        
        let identifier: String
        let status: Status
        init(identifier: String, status: Status) {
            self.identifier = identifier
            self.status = status
        }
        
        static func == (lhs: Game.Status, rhs: Game.Status) -> Bool {
            return lhs.status == rhs.status
        }
    }
    
    let identifier: String
    let user: User
    let partner: User
    let rounds: [Round]
    let startDate: Date?
    let endDate: Date?
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.user == rhs.user &&
            lhs.partner == rhs.partner &&
            lhs.rounds == rhs.rounds &&
            lhs.startDate == rhs.startDate &&
            lhs.endDate == rhs.endDate
    }
    
    init(identifier: String,
         user: User, partner: User,
         startDate: Date? = nil,
         endDate: Date? = nil,
         rounds: [Round]) {
        self.identifier = identifier
        self.user = user
        self.partner = partner
        self.startDate = startDate
        self.endDate = endDate
        self.rounds = rounds
    }
    
    func summary() -> Summary {
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

    func status() -> Status {
        switch (self.startDate, self.endDate) {
        case (.none, .none):
            return Status(identifier: self.identifier, status: .waiting)
        case (.some, .none):
            return Status(identifier: self.identifier, status: .inProgress)
        case (_, .some(let endDate)):
            return Status(identifier: self.identifier, status: .finished(endDate))
        }
    }
    
    func timeLeft() -> Double? {
        return nil
    }
}

class Answer: Equatable {
    let identifier: String
    let content: [String : String]
    
    init(identifier: String, content:  [String : String]) {
        self.identifier = identifier
        self.content = content
    }
    
    static func == (lhs: Answer, rhs: Answer) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.content == rhs.content;
    }
}

class Question: Equatable {
    let identifier: String
    let content:  [String : String]
    let answers: [Answer]
    
    init(identifier: String,
         content:  [String : String],
         answers: [Answer]) {
        self.identifier = identifier
        self.content = content
        self.answers = answers
    }
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.content == rhs.content &&
            lhs.answers == rhs.answers;
    }
}

class Quiz: Equatable {
    let identifier: String
    let name: String
    let questions: [Question]
    
    init(identifier: String, name: String ,questions: [Question]) {
        self.identifier = identifier
        self.name = name
        self.questions = questions
    }
    
    static func == (lhs: Quiz, rhs: Quiz) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.name == rhs.name &&
            lhs.questions == rhs.questions;
    }
}


class RoundUserInfo: Equatable {
    enum Status: Equatable {
        case answers([Bool])
        case text(String)
    }
    let user: User
    let score: Int
    let status: Status
    
    init(user: User, score: Int, status: Status) {
        self.user = user
        self.score = score
        self.status = status
    }
    
    static func == (lhs: RoundUserInfo, rhs: RoundUserInfo) -> Bool {
        return lhs.user == rhs.user &&
            lhs.score == rhs.score &&
            lhs.status == rhs.status;
    }
}

class Round: Equatable {
    
    let identifier: String
    let quiz: Quiz
    let roundUserInfo: RoundUserInfo
    let roundPartnerInfo: RoundUserInfo
    
    init(identifier: String,
         quiz: Quiz,
         roundUserInfo: RoundUserInfo,
         roundPartnerInfo: RoundUserInfo) {
        self.identifier = identifier
        self.quiz = quiz
        self.roundUserInfo = roundUserInfo
        self.roundPartnerInfo = roundPartnerInfo
    }
    
    static func == (lhs: Round, rhs: Round) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.quiz == rhs.quiz &&
            lhs.roundUserInfo == rhs.roundUserInfo &&
            lhs.roundPartnerInfo == rhs.roundPartnerInfo;
    }
    
}

//MARK: ListDiffable

extension User: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.identifier as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? User else {return false }
        return self == object
    }
    
}


extension Game: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.identifier as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Game else {return false }
        return self == object
    }
}

extension Game.Summary: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return "\(String(describing: type(of: self)))_\(self.identifier)" as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Game.Summary else {return false }
        return self == object
    }
}


extension Game.Status: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return "\(String(describing: type(of: self)))_\(self.identifier)" as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Game.Status else {return false }
        return self == object
    }
}


extension Answer: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.identifier as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Answer else {return false }
        return self == object
    }
}

extension Question: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.identifier as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Question else {return false }
        return self == object
    }
}

extension Quiz: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.identifier as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Quiz else {return false }
        return self == object
    }
}

extension RoundUserInfo: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.user.identifier as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? RoundUserInfo else {return false }
        return self == object
    }
}

extension Round: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.identifier as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Round else {return false }
        return self == object
    }
}
