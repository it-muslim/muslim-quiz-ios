//
//  Game.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import ObjectMapper

struct Game: Equatable {
    let identifier: String
    var userInfos: [GameUserInfo]
    let roundIds: [String]
    let startDate: Date?
    let endDate: Date?
    let status: GameStatus
    
    var summary: GameSummary {
        return GameSummary(identifier: self.identifier,
                           userInfos: self.userInfos)
    }
    
    /// Requited join
    var rounds = [Round]()
}

// MARK: JSON Decoding

extension Game: ImmutableMappable {
    
    init(map: Map) throws {
        let identifier: String = try map.value("identifier")
        let userInfos: [GameUserInfo] = {
            guard let userJSONs = map.JSON["users"] as? [String : [String : Any]] else {
                return [GameUserInfo]()
            }
            
            return userJSONs.compactMap {
                let key = $0.key
                var value = $0.value
                value["identifier"] = key
                return GameUserInfo(JSON: value)
            }
        }()
        let roundIds: [String] = {
            do {
                return try map.value("rounds")
            }
            catch {
                return  [String]()
            }
        }()
        let startDate: Date? = try? map.value("startDate", using: DateTransform())
        let endDate: Date? = try? map.value("endDate", using: DateTransform())
        
        let statusRaw: String = try map.value("status")
        let status: GameStatus = try {
            return try GameStatus(JSON: ["identifier": identifier,
                                         "status": statusRaw])
        }()
        
        self.identifier = identifier
        self.userInfos = userInfos
        self.roundIds = roundIds
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
    }
    
}

// MARK: Diffable

extension Game: Diffable {
    
    var diffIdentifier: String {
        return self.identifier
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Game else { return false }
        return self == object
    }
}
