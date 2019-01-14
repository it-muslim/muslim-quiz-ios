//
//  RoundPresenter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 15/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation
import IGListKit.IGListDiffable

protocol RoundPresenterProtocol: PresenterProtocol {
    func reportRequested()
    func skipRequested()
    func giveUpRequested()
}

class RoundPresenter : Presenter, RoundPresenterProtocol {
    
    var router: RoundRouterProtocol!
    weak var view: RoundView!
    private let round: Round
    private var currentQuestionIdx = 0

    init(round: Round) {
        self.round = round
        super.init()
    }
    
    override func viewDidLoad() {
        var items = [Diffable]()
        items.append(self.round.roundSummary(roundIndex: round.index ?? 0,
                                             questionIndex: currentQuestionIdx))
        if let topic = self.round.topic, topic.questions.count > self.currentQuestionIdx {
            items.append(topic.questions[self.currentQuestionIdx])
        }
        items.append(self.round.status)
        self.view.configure(listObjects: items.map { $0.diffable() } )
        
    }
    
    func reportRequested() {
        
    }
    
    func skipRequested() {
        
    }
    
    func giveUpRequested() {
        self.view.showGiveUp()
    }
    
}
