//
//  GameSection.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit.IGListDiffable

struct GameSection {
    let title: String
    let games: [Game]
    var collapsed: Bool = false
}

extension GameSection: Equatable {
    
    static func == (lhs: GameSection, rhs: GameSection) -> Bool {
        return lhs.title == lhs.title && lhs.games == lhs.games
    }
    
}


extension GameSection: Diffable {
    
    var diffIdentifier: String {
        return self.title
    }
    
    func isEqual(toDiffableObject object: Diffable?) -> Bool {
        guard let gameSection = object as? GameSection else { return false }
        return self == gameSection
    }
    
}
