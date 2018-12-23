//
//  Round.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation

struct Round {
    struct RoundSummary {
        let identifier: String
        let title: String
        let index: Int
        let questionCount: Int
        let questionIndex: Int
        
        init(identifier: String,
             title: String,
             index: Int,
             questionCount: Int,
             questionIndex: Int) {
            self.identifier = identifier
            self.title = title
            self.index = index
            self.questionCount = questionCount
            self.questionIndex = questionIndex
        }
    }
    
    struct Status {
        enum Status: Equatable {
            case waiting
            case inProgress
            case finished(Date)
            case expired(Date)
            case givedUp(Date?)
        }
        
        let identifier: String
        let status: Status
        init(identifier: String, status: Status) {
            self.identifier = identifier
            self.status = status
        }
        
    }
    
    let identifier: String
    let topic: Topic
    let roundUserInfo: RoundUserInfo
    let roundPartnerInfo: RoundUserInfo
    let index: Int
    let giveUp: Bool
    let startDate: Date?
    let endDate: Date?
    let status: Status

    func roundSummary(questionIndex: Int) -> RoundSummary {
        return RoundSummary(identifier: self.identifier,
                            title: "Раунд \(self.index) против \(self.roundPartnerInfo.user.name)",
            index: self.index,
            questionCount: self.topic.questions.count,
            questionIndex: questionIndex)
    }
}

extension Round: Diffable, Equatable {
    var diffIdentifier: String {
        return self.identifier
    }
    
    static func == (lhs: Round, rhs: Round) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.topic == rhs.topic &&
            lhs.roundUserInfo == rhs.roundUserInfo &&
            lhs.roundPartnerInfo == rhs.roundPartnerInfo;
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Round else { return false }
        return self == object
    }
}

extension Round.Status {
    var diffIdentifier: String {
        return "\(String(describing: type(of: self)))_\(self.identifier)"
    }
    
    static func == (lhs: Round.Status, rhs: Round.Status) -> Bool {
        return lhs.status == rhs.status
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Round.Status else { return false }
        return self == object
    }
}

extension Round.RoundSummary {
    var diffIdentifier: String {
        return self.identifier
    }
    static func == (lhs: Round.RoundSummary, rhs: Round.RoundSummary) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.title == rhs.title &&
            lhs.index == rhs.index &&
            lhs.questionCount == rhs.questionCount &&
            lhs.questionIndex == rhs.questionIndex;
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Round.RoundSummary else { return false }
        return self == object
    }
}
