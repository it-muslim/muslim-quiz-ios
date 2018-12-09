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
    func startGameRequested()
    func openGameRequested(_ game: Game)
}

class HomePresenter : Presenter, HomePresenterProtocol {
    
    var router: HomeRouterProtocol!
    weak var view: HomeView!
    
    
    override func viewDidLoad() {
        var rounds = [Round]()
        let user1 = User(identifier: "user\(1)",
            name: "Амин \(1)",
            level: "Студент \(1)",
            score: 10)
        let user2 = User(identifier: "user\(2)",
            name: "Амин \(2)",
            level: "Студент \(2)",
            score: 10);
        let roundUserInfo = RoundUserInfo(user: user1,
                                            score: 10,
                                            status: .text("Сдался :)"))
        let roundPartnerInfo = RoundUserInfo(user: user2,
                                            score: 10,
                                            status: .answers([true, false, false]))
        for i in 0..<3 {
            var questions = [Question]()
            for qIdx in 0..<3 {
                var answers = [Answer]()
                for rIdx in 0..<4 {
                    answers.append(Answer(identifier: "\(i).\(qIdx) answers \(rIdx)",
                        content: ["text": "\(i).\(qIdx) Super answer \(rIdx)"]))
                }
                questions.append(Question(identifier: "\(i). question \(qIdx)",
                    content: ["text" : "\(i) Super question \(qIdx)"],
                    answers: answers))
            }
            rounds.append(Round(identifier: "round \(i)",
                quiz: Quiz(identifier: "quiz \(i)",
                    name: "quiz name \(i)",
                    questions: questions),
                roundUserInfo: roundUserInfo,
                roundPartnerInfo: roundPartnerInfo))
        }
        var games = [Game]()
        for i in 0..<4 {
            games.append(Game(identifier: "\(i)",
                              user: User(identifier: "user\(i)",
                                         name: "Амин \(i)",
                                         level: "Студент \(i)",
                                         score: 10*i),
                              partner: User(identifier: "user\(i)",
                                           name: "Амин \(i)",
                                           level: "Ученик \(i)",
                                            score: 11*i),
                              rounds: rounds))
        }
        var gameSections = [GameSection]()
        for i in 0...2 {
            gameSections.append(GameSection(title: "Секция \(i)",
                games: games))
        }
        self.view.configure(listObjects: gameSections )
    }
    
    func startGameRequested() {
        self.router.openChoosePartner()
    }
    
    func openGameRequested(_ game: Game) {
        self.router.openGame(game)
    }
    
}
