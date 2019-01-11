//
//  GameHeaderSectionController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit

class GameHeaderSectionController: ListSectionController {
    
    var gameSummary : GameSummary
    init(gameSummary: GameSummary) {
        self.gameSummary = gameSummary
        super.init()
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
     
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = self.collectionContext!.dequeueReusableCell(withNibName: "GameSummaryCell",
                                                               bundle: Bundle.main,
                                                               for: self,
                                                               at: index) as! GameSummaryCell
        cell.configure(gameSummary: self.gameSummary)
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width,
                      height: GameSummaryCell.height)
    }
    
    override func didUpdate(to object: Any) {
        self.collectionContext!.performBatch(animated: true, updates: { (listBatchContext) in
            self.gameSummary = (object as! DiffableBox).value as! GameSummary
        }, completion: nil)
    }
    
    override func didSelectItem(at index: Int) {
        
    }
    
}
