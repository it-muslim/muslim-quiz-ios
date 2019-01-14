//
//  GameViewController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit

protocol GameView: ViewProtocol {
    func configure(items: [ListDiffable])
}

class GameViewController: ViewController {
    
    public var adapterDataSource: SectionSourceServiceProtocol!
    private var adapter : ListAdapter!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var presenter: GamePresenterProtocol!
    override var presenterRef: PresenterProtocol! {
        get {
            return presenter
        }
    }
    
    override func viewDidLoad() {
        self.setupViews()
        super.viewDidLoad()
    }
    
    //MARK: Private
    
    private func setupViews() {
        self.setupList()
    }
    
    private func setupList() {
        self.adapter = ListAdapter(updater: ListAdapterUpdater(),
                                   viewController: self)
        let collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.setCollectionViewLayout(collectionViewLayout,
                                                    animated: false)
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self.adapterDataSource
    }
    
}

extension GameViewController: GameView {
    
    func configure(items: [ListDiffable]) {
        self.adapterDataSource.listObjects = items
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
}

extension GameViewController : GameFooterDelegate {
    
    func giveUp() {
        self.presenter.giveUpRequested()
    }
    
    func play() {
        self.presenter.playRequested()
    }
    
    func rematch() {
        self.presenter.rematchRequested()
    }
    
}
