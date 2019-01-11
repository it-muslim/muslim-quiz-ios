//
//  Round.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import ObjectMapper

struct Round: Equatable {
    let identifier: String
    let topic: Topic
    let currentUser: User
    let userInfos: [RoundUserInfo]
    let startDate: Date?
    let endDate: Date?
    let status: RoundStatus

    func roundSummary(roundIndex :Int, questionIndex: Int) -> RoundSummary {
        let userNames = { () -> String in
            return self.userInfos
                .filter { $0.user != self.currentUser }
                .map { $0.user?.fullName ?? $0.userId }.joined(separator: ",")
        }()
        return RoundSummary(identifier: self.identifier,
                            title: "Раунд \(roundIndex) против \(userNames)",
            questionCount: self.topic.questions.count,
            questionIndex: questionIndex)
    }
}

// MARK: JSON Decoding

extension Round: ImmutableMappable {
    init(map: Map) throws {
        let identifier: String = try map.value("identifier")
        let topic : Topic = try map.value("topic")
        let currentUser : User = try map.value("currentUser")
        let userInfos: [RoundUserInfo] = {
            guard let userJSONs = map.JSON["users"] as? [String : [String : Any]] else {
                return [RoundUserInfo]()
            }

            return userJSONs.compactMap {
                let key = $0.key
                var value = $0.value
                value["identifier"] = key
                return RoundUserInfo(JSON: value)
            }
        }()
        let startDate: Date? = try? map.value("startDate", using: DateTransform())
        let endDate: Date? = try? map.value("endDate", using: DateTransform())
        let statusRaw: String = try map.value("status")
        let status: RoundStatus = try {
            return try RoundStatus(JSON: ["identifier": identifier,
                                         "status": statusRaw])
            }()

        self.identifier = identifier
        self.topic = topic
        self.currentUser = currentUser
        self.userInfos = userInfos
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
    }
}

// MARK: Diffable

extension Round: Diffable {
    var diffIdentifier: String {
        return self.identifier
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Round else { return false }
        return self == object
    }
}

