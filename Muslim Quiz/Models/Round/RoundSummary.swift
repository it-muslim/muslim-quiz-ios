//
//  RoundSummary.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 06/01/2019.
//  Copyright © 2019 Amin Benarieb. All rights reserved.
//

import ObjectMapper

struct RoundSummary: Equatable {
    let identifier: String
    let title: String
    let questionCount: Int
    let questionIndex: Int
}

// MARK: JSON Decoding

extension RoundSummary: Diffable {
    var diffIdentifier: String {
        return self.identifier
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? RoundSummary else { return false }
        return self == object
    }
}
