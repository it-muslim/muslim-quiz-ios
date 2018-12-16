//
//  RoundViewController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 15/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit

protocol RoundView: ViewProtocol {
    func configure(listObjects: [ListDiffable])
    func showGiveUp()
}

class RoundViewController: ViewController {
    
    public var adapterDataSource: SectionSourceServiceProtocol!
    public var dialogFactory: DialogFactoryProtocol!
    private var adapter : ListAdapter!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var presenter: RoundPresenterProtocol!
    override var presenterRef: PresenterProtocol! {
        get {
            return presenter
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
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

extension RoundViewController: RoundView {
    
    func configure(listObjects: [ListDiffable]) {
        self.adapterDataSource.listObjects = listObjects
    }
    
    func showGiveUp() {
        self.dialogFactory.present(in: self, status: .giveUp)
    }
    
}

extension RoundViewController: RoundHeaderDelegate {
    
    func giveUp() {
        self.presenter.giveUpRequested()
    }
    
}


extension RoundViewController: RoundFooterDelegate {
    
    func skip() {
    }
    
    func report() {
        self.presenter.reportRequested()
    }
    
}
