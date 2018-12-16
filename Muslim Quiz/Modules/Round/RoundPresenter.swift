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
        var listObjects = [ListDiffable]()
        listObjects.append(self.round.roundSummary(questionIndex: currentQuestionIdx))
        listObjects.append(self.round.quiz.questions[currentQuestionIdx])
        listObjects.append(self.round.status())
        self.view.configure(listObjects: listObjects)
    }
    
}
