//
//  GameFooterSection.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit

class GameFooterSectionController: ListSectionController {
    
    var gameStatus : GameStatus
    init(gameStatus: GameStatus) {
        self.gameStatus = gameStatus
        super.init()
        self.inset = UIEdgeInsets(top: 0,
                                  left: 0,
                                  bottom: 20,
                                  right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = self.collectionContext!.dequeueReusableCell(withNibName: "GameFooterCell",
                                                               bundle: Bundle.main,
                                                               for: self,
                                                               at: index) as! GameFooterCell
        cell.configure(gameStatus: self.gameStatus)
        cell.delegate = self.viewController as? GameFooterDelegate
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width,
                      height: GameFooterCell.height)
    }
    
    override func didUpdate(to object: Any) {
        self.collectionContext!.performBatch(animated: true, updates: { (listBatchContext) in
            self.gameStatus = (object as! DiffableBox).value as! GameStatus
        }, completion: nil)
    }
    
    override func didSelectItem(at index: Int) {
        
    }
    
}

