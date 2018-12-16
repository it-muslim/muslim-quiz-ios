//
//  RoundQuestionSectionController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 15/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit

class RoundQuestionSectionController: ListSectionController {
    
    var question: Question
    init(question: Question) {
        self.question = question
        super.init()
    }
    
    override func numberOfItems() -> Int {
        return self.question.answers.count + 2
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            let roundProgressCell = self.collectionContext!.dequeueReusableCell(withNibName: "RoundProgressCell",
                                                                                   bundle: Bundle.main,
                                                                                   for: self,
                                                                                   at: index) as! RoundProgressCell
            roundProgressCell.configure(progress: 0.5) //TODO: Replace with timer
            return roundProgressCell
        case 1:
            let roundQuestionCell = self.collectionContext!.dequeueReusableCell(withNibName: "RoundQuestionCell",
                                                                                bundle: Bundle.main,
                                                                                for: self,
                                                                                at: index) as! RoundQuestionCell
            roundQuestionCell.configure(question: self.question)
            return roundQuestionCell
        default:
            let aoundAnswerCell = self.collectionContext!.dequeueReusableCell(withNibName: "RoundAnswerCell",
                                                                                   bundle: Bundle.main,
                                                                                   for: self,
                                                                                   at: index) as! RoundAnswerCell
            aoundAnswerCell.configure(answer: self.question.answers[index - 2])
            return aoundAnswerCell
        }
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = self.collectionContext!.containerSize.width
        let height : CGFloat = {
            switch index {
            case 0:
                return RoundProgressCell.height
            case 1:
                return RoundQuestionCell.height(for: self.question,
                                                with: width)
            default:
                return RoundAnswerCell.height(for: self.question.answers[index - 2],
                                              with: width)
            }
        }()
        return CGSize(width: width,
                      height: height)
    }
    
    override func didUpdate(to object: Any) {
        self.collectionContext!.performBatch(animated: true, updates: { (listBatchContext) in
            self.question = object as! Question
        }, completion: nil)
    }
    
}
