//
//  GameSummary.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 06/01/2019.
//  Copyright © 2019 Amin Benarieb. All rights reserved.
//

import Foundation

struct GameSummary {
    let identifier: String
    let userInfos: [GameUserInfo]
}

// MARK: Diffable

extension GameSummary: Diffable {
    
    var diffIdentifier: String {
        return "\(String(describing: type(of: self)))_\(self.identifier)"
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? GameSummary else { return false }
        return self == object
    }
}

// MARK: Equatable

extension GameSummary: Equatable {
    
    static func == (lhs: GameSummary, rhs: GameSummary) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.userInfos == rhs.userInfos;
    }
}
