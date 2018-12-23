//
//  Topic.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation

struct Topic {
    let identifier: String
    let name: String
    let questions: [Question]
}

extension Topic: Diffable, Equatable {
    var diffIdentifier: String {
        return self.identifier
    }
    
    static func == (lhs: Topic, rhs: Topic) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.name == rhs.name &&
            lhs.questions == rhs.questions;
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Topic else { return false }
        return self == object
    }
}


