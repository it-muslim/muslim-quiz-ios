//
//  HomePresenter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation
import IGListKit

protocol HomePresenterProtocol: PresenterProtocol {
    
}

class HomePresenter : Presenter, HomePresenterProtocol {
    
    var router: HomeRouterProtocol!
    weak var view: HomeView!
    
    
    override func viewDidLoad() {
        var games = [Game]()
        for i in 0..<4 {
            games.append(Game(identifier: "\(i)",
                              user: User(identifier: "user1",
                                         name: "Амин 1"),
                              parner: User(identifier: "user1",
                                         name: "Амин 2"),
                              timeLeft: nil))
        }
        var gameSections = [GameSection]()
        for i in 0...2 {
            gameSections.append(GameSection(title: "Секция \(i)",
                games: games))
        }
        self.view.configure(listObjects: gameSections )
    }
    
}
