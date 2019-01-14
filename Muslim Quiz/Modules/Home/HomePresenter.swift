//
//  HomePresenter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation
import Firebase

protocol HomePresenterProtocol: PresenterProtocol {
    func startGameRequested()
    func signOutRequested()
    func openGameRequested(_ game: Game)
}

class HomePresenter : Presenter, HomePresenterProtocol {
    
    var router: HomeRouterProtocol!
    weak var view: HomeView!
    
    private var auth: Auth = Auth.auth() //TODO: Inject and wrap?
    private var databaseRef: DatabaseReference! = Database.database().reference() //TODO: Inject and wrap?
    private var gamesObserver: DatabaseHandle?
    
    // Destructor
    
    deinit {
        if let gamesObserver = self.gamesObserver {
            self.databaseRef.removeObserver(withHandle: gamesObserver)
        }
    }
    
    // MARK: Events
    
    override func viewDidLoad() {
        self.loadData()
    }
    
    func startGameRequested() {
        self.router.openChoosePartner()
    }
    
    func openGameRequested(_ game: Game) {
        self.router.openGame(game)
    }
    
    func signOutRequested() {
        do {
            try self.auth.signOut()
        } catch let signOutError as NSError {
            self.view.showError(msg: signOutError.localizedDescription)
        }
        
    }
    
    // MARK: Private
    
    private func loadData() {
        self.gamesObserver = self.databaseRef.child("games")
            .observe(.value,
                     with:
                { [weak self] (snapshot) in
                    guard let storngSelf = self,
                        let gameJSONs = snapshot.value as? [String : [String : Any]] else {
                        return
                    }
                    
                    let games = gameJSONs
                        .compactMap({ (gameJSON) -> Game? in
                            let key = gameJSON.key
                            var value = gameJSON.value
                            
                            value["identifier"] = key
                            return try? Game(JSON: value)
                        })
                    
                    let gameSections = storngSelf.gameSections(from: games)
                    self?.view.configure(listObjects: gameSections.map { $0.diffable() })
                
            }, withCancel: { [weak self] (error) in
                self?.view.showError(msg: error.localizedDescription)
            })
    }
    
    private func gameSections(from games: [Game]) -> [GameSection] {
        var gameSections = [GameSection]()
        let waitingGames = games.filter { $0.status.status == .waiting }
        if (waitingGames.count != 0) {
            gameSections.append(GameSection(title:"Ожидание", games: waitingGames, collapsed: false))
        }
        let playtingGames = games.filter { $0.status.status == .playing }
        if (playtingGames.count != 0) {
            gameSections.append(GameSection(title:"Текущие", games: playtingGames, collapsed: false))
        }
        let finishedGames = games.filter { $0.status.status == .finished }
        if (finishedGames.count != 0) {
            gameSections.append(GameSection(title:"Оконченные", games: finishedGames, collapsed: false))
        }
        let rejectedGames = games.filter { $0.status.status == .rejected }
        if (rejectedGames.count != 0) {
            gameSections.append(GameSection(title:"Отклоненные", games: rejectedGames, collapsed: false))
        }
        return gameSections
    }
    
    
}
