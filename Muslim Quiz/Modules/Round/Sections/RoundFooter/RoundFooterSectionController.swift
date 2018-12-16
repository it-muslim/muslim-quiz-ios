//
//  RoundFooterSectionController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 16/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit

class RoundFooterSectionController: ListSectionController {
    
    private let roundStatus : Round.Status
    
    init(status: Round.Status) {
        self.roundStatus = status
        super.init()
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let roundFooterCell = self.collectionContext!.dequeueReusableCell(withNibName: "RoundFooterCell",
                                                                          bundle: Bundle.main,
                                                                          for: self,
                                                                          at: index) as! RoundFooterCell
        roundFooterCell.configure(roundStatus: self.roundStatus)
        roundFooterCell.delegate = self.viewController as? RoundFooterDelegate
        return roundFooterCell
        
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = self.collectionContext!.containerSize.width
        let height = RoundFooterCell.height()
        return CGSize(width: width,
                      height: height)
    }
    
}
