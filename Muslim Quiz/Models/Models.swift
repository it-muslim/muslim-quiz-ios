//
//  Game.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit.IGListDiffable

//TODO: Split in files

class User: Equatable {
    let identifier: String
    let name: String
    
    init(identifier: String, name: String) {
        self.identifier = identifier
        self.name = name
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name
    }
}

class Game: Equatable {
    let identifier: String
    let user: User
    let parner: User
    let timeLeft: Float?
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.user == rhs.user && lhs.timeLeft == rhs.timeLeft
    }
    
    init(identifier: String, user: User, parner: User, timeLeft: Float?) {
        self.identifier = identifier
        self.user = user
        self.parner = parner
        self.timeLeft = timeLeft
    }
}

//MARK: ListDiffable

extension User: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.identifier as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let user = object as? User else {return false }
        return self.name == user.name
    }
    
}


extension Game: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.identifier as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let game = object as? Game else {return false }
        return self == game
    }
}
