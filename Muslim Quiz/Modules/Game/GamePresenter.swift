//
//  GamePresenter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation

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
        let items = [self.game.summary,
                     self.game.rounds,
                     self.game.status] as! [Diffable]
        self.view.configure(items: items.map{ $0.diffable() } )
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
