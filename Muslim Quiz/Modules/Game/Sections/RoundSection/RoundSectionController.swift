//
//  RoundSectionController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit
import Firebase

class RoundSectionController: ListSectionController {
    
    private var round : Round
    init(round: Round) {
        self.round = round
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = self.collectionContext!.dequeueReusableCell(withNibName: "RoundCell",
                                                               bundle: Bundle.main,
                                                               for: self,
                                                               at: index) as! RoundCell
        cell.configure(number: self.section + 1, round: round)
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width,
                      height: RoundCell.height)
    }
    
    override func didUpdate(to object: Any) {
        self.collectionContext!.performBatch(animated: true, updates: { (listBatchContext) in
            self.round = (object as! DiffableBox).value as! Round
        }, completion: nil)
    }
    
    override func didSelectItem(at index: Int) {
        
    }
    
}
