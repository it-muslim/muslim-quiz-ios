//
//  Question.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation

struct Question {
    let identifier: String
    let content:  [String : String]
    let topic: Topic
    let answers: [Answer]
}

extension Question: Diffable, Equatable {
    var diffIdentifier: String {
        return self.identifier
    }
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.content == rhs.content &&
            lhs.answers == rhs.answers;
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Question else { return false }
        return self == object
    }
}
