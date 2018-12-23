//
//  HomePresenter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation
import Firebase
import IGListKit

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
    
    override func viewDidLoad() {
        self.databaseRef.child("games").observe(DataEventType.value,
                                                with:
            { (snapshot) in
                let gameJSONs = snapshot.value as? [String : AnyObject] ?? [:]
                gameJSONs.map({ (<#(key: String, value: AnyObject)#>) -> T in
                    <#code#>
                })
        }) { (error) in
            
        }
        // 1. get games
        // 2. split by status into section
        var games = [Game]()
//        Game(identifier: "\(i)",
//            user: User(identifier: "user\(i)",
//                name: "Амин \(i)",
//                level: "Студент \(i)",
//                score: 10*i),
//            partner: User(identifier: "user\(i)",
//                name: "Амин \(i)",
//                level: "Ученик \(i)",
//                score: 11*i),
//            startDate: Date(),
//            rounds: rounds)
//        GameSection(title: "Секция \(i)", games: games)
        var gameSections = [GameSection]()
        self.view.configure(listObjects: gameSections)
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
    
}
