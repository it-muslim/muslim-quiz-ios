//
//  GameSectionController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit

protocol GameSectionDelegate {
    func openGame(game: Game)
}

class GameSectionController: ListSectionController {
    
    private var gameSection : GameSection
    private var delegate: GameSectionDelegate? {
        return self.viewController as? GameSectionDelegate
    }
    
    init(gameSection: GameSection) {
        self.gameSection = gameSection
        super.init()
        self.supplementaryViewSource = self
    }
    
    override func numberOfItems() -> Int {
        return self.gameSection.collapsed ? 0 : self.gameSection.games.count
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let gameCell =  self.collectionContext!.dequeueReusableCell(withNibName: "GameCell",
                                                                    bundle: Bundle.main,
                                                                    for: self,
                                                                    at: index) as! GameCell
        let game = self.gameSection.games[index]
        gameCell.configure(partnerName: game.userInfos[1].user.name)
        return gameCell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width,
                      height: GameCell.height)
    }
    
    override func didUpdate(to object: Any) {
        self.collectionContext!.performBatch(animated: true, updates: { (listBatchContext) in
            self.gameSection = object as! GameSection
        }, completion: nil)
    }
    
    override func didSelectItem(at index: Int) {
        self.delegate?.openGame(game: self.gameSection.games[index])
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
        gamesHeaderView.configure(title: self.gameSection.title,
                                  collapsed: self.gameSection.collapsed)
        gamesHeaderView.delegate = self
        return gamesHeaderView
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String,
                                  at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width,
                      height: GamesHeaderView.height)
    }
    
}

extension GameSectionController: GamesHeaderViewDelegate {
    
    func toggleCollapse() {
        self.collectionContext?.performBatch(animated: true, updates: { (listBatchContext) in
            self.gameSection.collapsed = !self.gameSection.collapsed
            listBatchContext.reload(self)
        }, completion: nil)
    }
    
}
