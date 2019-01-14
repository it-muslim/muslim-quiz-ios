//
//  GamePresenter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation
import Firebase


protocol GamePresenterProtocol: PresenterProtocol {
    
    func giveUpRequested()
    func rematchRequested()
    func playRequested()
    
}

class GamePresenter : Presenter, GamePresenterProtocol {
    
    var router: GameRouterProtocol!
    weak var view: GameView!
    private var game: Game
    private let roundIndex = 0
    private var databaseRef: DatabaseReference! = Database.database().reference() //TODO: Inject and wrap?
    private var roundsObservers = [DatabaseHandle]()
    private var usersObservers = [DatabaseHandle]()
    private var auth: Auth = Auth.auth() //TODO: Inject and wrap?
    
    // MARK: Constructor & Destructor
    
    init(game: Game) {
        self.game = game
        super.init()
    }
    
    deinit {
        self.remove(observers: &self.roundsObservers)
        self.remove(observers: &self.usersObservers)
    }
    
    // MARK: Events
    
    override func viewDidLoad() {
        self.configureView()
        self.loadData()
    }
    
    func giveUpRequested() {
        
    }
    
    func rematchRequested() {
        
    }
    
    func playRequested() {
        let round = self.game.rounds[roundIndex]
        self.router.openRound(round: round)
    }
    
    // MARK: - Private
    
    private func configureView() {
        var items = [Diffable]()
        items.append(self.game.summary)
        if self.game.rounds.count != 0 {
            items.append(contentsOf: self.game.rounds)
        }
        items.append(self.game.status)
        
        self.view.configure(items: items.map{ $0.diffable() } )
    }
    
    private func loadData() {
        self.loadUserInfos()
        self.loadRounds()
    }
    
    private func loadUserInfos() {
        self.remove(observers: &self.usersObservers)
        
        self.usersObservers = self.game.userInfos.map { (userInfo) in
            return self.databaseRef.child("users/\(userInfo.identifier)")
                .observe(.value,
                         with:
                    
                    { [weak self] (snapshot) in
                        self?.process(userSnapshot: snapshot)
                        
                    }, withCancel: { [weak self] (error) in
                        self?.process(error: error)
                })
            
        }
    }
    
    private func loadRounds() {
        self.remove(observers: &self.roundsObservers)
        
        self.roundsObservers = self.game.roundIds.map { (roundId) in
            return self.databaseRef.child("rounds/\(roundId)")
                .observe(.value,
                         with:
                    { [weak self] (snapshot) in
                        self?.process(roundSnapshot: snapshot)
                        
                    }, withCancel: { [weak self] (error) in
                        self?.process(error: error)
                })
            
        }
    }
    
    private func loadCurrentUser(for roundIndex: Int) {
        guard let uid = self.auth.currentUser?.uid else {
            return
        }
        
        self.databaseRef.child("users/\(uid)")
            .observeSingleEvent(of: .value) { (snapshot) in
                guard let userJSON = snapshot.JSONItem else {
                    return
                }
                
                self.game.rounds[roundIndex].currentUser = try? User(JSON: userJSON)
        }
    }
    
    private func loadTopic(for roundIndex: Int, topicId: String?) {
        guard let tid = topicId else {
            return
        }
        
        self.databaseRef.child("topics/\(tid)")
            .observeSingleEvent(of: .value) { (snapshot) in
                guard let topicJSON = snapshot.JSONItem else {
                    return
                }
                
                self.game.rounds[roundIndex].topic = try? Topic(JSON: topicJSON)
                self.configureView()
        }
    }
    
    // MARK: Utils
    
    private func process(userSnapshot: DataSnapshot) {
        guard let userJSON = userSnapshot.JSONItem else {
            return
        }
        
        let userInfos = self.game.userInfos.filter { $0.identifier == userSnapshot.key }
        guard let userInfo = userInfos.first, let index = userInfos.firstIndex(of: userInfo) else {
            return
        }
        
        self.game.userInfos[index].user = try? User(JSON: userJSON)
        self.configureView()
    }
    
    private func process(roundSnapshot: DataSnapshot) {
        guard let roundJSON = roundSnapshot.JSONItem,
            let round = try? Round(JSON: roundJSON) else {
            return
        }
       
        self.loadCurrentUser(for: self.game.rounds.count)
        self.loadTopic(for: self.game.rounds.count,
                       topicId: roundJSON["topic"] as? String)
        
        self.game.rounds.append(round)
        self.configureView()
    }
    
    private func process(error: Error) {
        self.view.showError(msg: error.localizedDescription)
    }
    
    private func remove(observers: inout [DatabaseHandle]) {
        while let observer = observers.popLast() {
            self.databaseRef.removeObserver(withHandle: observer)
        }
    }
    
}
