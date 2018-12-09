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
    
}

class GamePresenter : Presenter, GamePresenterProtocol {
    
    var router: GameRouterProtocol!
    weak var view: GameView!
    private let game: Game
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
    
}
