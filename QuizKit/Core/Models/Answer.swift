//
//  Answer.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import ObjectMapper

struct Answer: Equatable {
    let identifier: String
    let content: [String : String]
}

// MARK: JSON Decoding

extension Answer: ImmutableMappable {
    
    init(map: Map) throws {
        self.identifier = try map.value("identifier")
        self.content = try map.value("content")
    }
}

// MARK: Diffable
        
extension Answer: Diffable {
    var diffIdentifier : String {
        return self.identifier
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Answer else { return false }
        return self == object
    }
}
