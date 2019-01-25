//
//  Topic.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import ObjectMapper

struct Topic: Equatable {
    let identifier: String
    let name: String
    let questions: [Question]
}


// MARK: ObjectMapper

extension Topic: ImmutableMappable {
    
    init(map: Map) throws {
        self.identifier = try map.value("identifier")
        self.name = try map.value("name")
        self.questions = {
            do {
                return try map.value("questions")
            }
            catch {
                return  [Question]()
            }
        }()
    }
}

// MARK: JSON Decoding

extension Topic: Diffable {
    
    var diffIdentifier: String {
        return self.identifier
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Topic else { return false }
        return self == object
    }
}


