//
//  RoundHeaderSectionController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 15/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit

class RoundHeaderSectionController: ListSectionController {
    
    var roundSummary : Round.RoundSummary
    init(roundSummary: Round.RoundSummary) {
        self.roundSummary = roundSummary
        super.init()
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let roundHeaderCell = self.collectionContext!.dequeueReusableCell(withNibName: "RoundHeaderCell",
                                                                          bundle: Bundle.main,
                                                                          for: self,
                                                                          at: index) as! RoundHeaderCell
        roundHeaderCell.delegate = self.viewController as? RoundHeaderDelegate
        roundHeaderCell.configure(roundSummary: self.roundSummary)
        return roundHeaderCell

    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = self.collectionContext!.containerSize.width
        let height = RoundHeaderCell.height(for: self.roundSummary, with: width)
        return CGSize(width: width,
                      height: height)
    }
    
    override func didUpdate(to object: Any) {
        self.collectionContext!.performBatch(animated: true, updates: { (listBatchContext) in
            self.roundSummary = object as! Round.RoundSummary
        }, completion: nil)
    }
    
}
