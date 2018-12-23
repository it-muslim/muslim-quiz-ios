//
//  Answer.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation

struct Answer {
    let identifier: String
    let content: [String : String]
}

extension Answer: Diffable, Equatable {
    var diffIdentifier : String {
        return self.identifier
    }
    
    static func == (lhs: Answer, rhs: Answer) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.content == rhs.content;
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let object = object as? Answer else { return false }
        return self == object
    }
}
