//
//  GameSection.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit.IGListDiffable

class GameSection: Equatable {
    let title: String
    let games: [Game]
    
    init(title: String, games: [Game]) {
        self.title = title
        self.games = games
    }
    
    static func == (lhs: GameSection, rhs: GameSection) -> Bool {
        return lhs.games == lhs.games
    }
    
}


extension GameSection: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.title as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let game = object as? GameSection else { return false }
        return self == game
    }
    
}
