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
        self.databaseRef.child("games")
            .observeSingleEvent(of: .value,
                                with:
                { [weak self] (snapshot) in
                    //TODO: Stop point
                    let gameJSONs = snapshot.value as? [[String : AnyObject]] ?? [[String : AnyObject]]()
                    let games = gameJSONs.map({ (gameJSON) -> Game? in
                        return Game(JSON: gameJSON)
                    })
                    

                    var gameSections = [GameSection]()
                    self?.view.configure(listObjects: gameSections)
            }, withCancel: { [weak self] (error) in
                self?.view.showError(msg: error.localizedDescription)
            })
            
//            .observe(DataEventType.value,
//                                                with:
//            { [weak self] (snapshot) in
//                let gameJSONs = snapshot.value as? [[String : AnyObject]] ?? [[String : AnyObject]]()
//                let games = gameJSONs.map({ (gameJSON) -> Game? in
//                    return Game(JSON: gameJSON)
//                })
//
//                var gameSections = [GameSection]()
//                self?.view.configure(listObjects: gameSections)
//        }) { [weak self] (error) in
//            self?.view.showError(msg: error)
//        }
    }
    
}
