//
//  Question.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import ObjectMapper

struct Question: Equatable {
    let identifier: String
    let content:  [String : String]
    let answers: [Answer]
}

// MARK: ObjectMapper

extension Question: ImmutableMappable {
    
    init(map: Map) throws {
        self.identifier = try map.value("identifier")
        self.content = try map.value("content")
        self.answers = {
            do {
                return try map.value("answers")
            }
            catch {
                return  [Answer]()
            }
        }()
    }
}

// MARK: JSON Decoding

extension Question: Diffable {
    var diffIdentifier: String {
        return self.identifier
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Question else { return false }
        return self == object
    }
}
