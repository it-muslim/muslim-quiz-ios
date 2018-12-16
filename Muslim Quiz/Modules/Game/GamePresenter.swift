//
//  GamePresenter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation
import IGListKit.IGListDiffable

protocol GamePresenterProtocol: PresenterProtocol {
    
    func giveUpRequested()
    func rematchRequested()
    func playRequested()
    
}

class GamePresenter : Presenter, GamePresenterProtocol {
    
    var router: GameRouterProtocol!
    weak var view: GameView!
    private let game: Game
    private let roundIndex = 0
    init(game: Game) {
        self.game = game
        super.init()
    }
    
    override func viewDidLoad() {
        var listObjects = [ListDiffable]()
        listObjects.append(self.game.summary())
        listObjects.append(contentsOf: self.game.rounds)
        listObjects.append(self.game.status())
        self.view.configure(listObjects: listObjects)
    }
    
    func giveUpRequested() {
        
    }
    
    func rematchRequested() {
        
    }
    
    func playRequested() {
        let round = self.game.rounds[roundIndex]
        self.router.openRound(round: round)
    }
    
}
