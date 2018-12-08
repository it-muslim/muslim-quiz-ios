//
//  GameSectionController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit

class GameSectionController: ListSectionController {
    
    private var gameSection : GameSection
    
    init(gameSection: GameSection) {
        self.gameSection = gameSection
        super.init()
        self.supplementaryViewSource = self
    }
    
    override func numberOfItems() -> Int {
        return self.gameSection.games.count
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let gameCell =  self.collectionContext!.dequeueReusableCell(withNibName: "GameCell",
                                                                    bundle: Bundle.main,
                                                                    for: self,
                                                                    at: index) as! GameCell
        let game = self.gameSection.games[index]
        gameCell.configure(partnerName: game.parner.name)
        return gameCell
    }
    
    override func didUpdate(to object: Any) {
        self.gameSection = object as! GameSection
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width,
                      height: GameCell.height)
    }
    
}

extension GameSectionController: ListSupplementaryViewSource {
    
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String,
                                     at index: Int) -> UICollectionReusableView {
        let gamesHeaderView = self.collectionContext!.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                       for: self,
                                                                                       nibName: "GamesHeaderView",
                                                                                       bundle: Bundle.main,                                                                              at: index) as! GamesHeaderView
        gamesHeaderView.configure(title: self.gameSection.title, collapsed: false)
        return gamesHeaderView
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String,
                                  at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width,
                      height: GamesHeaderView.height)
    }
    
}
