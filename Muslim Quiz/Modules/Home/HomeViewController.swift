//
//  HomeViewController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit
import IGListKit

protocol HomeView: ViewProtocol {
    func configure(listObjects: [ListDiffable])
}

class HomeViewController: ViewController {
    
    public var adapterDataSource: SectionSourceServiceProtocol!
    private var adapter : ListAdapter!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: HomePresenterProtocol!
    override var presenterRef: PresenterProtocol! {
        get {
            return presenter
        }
    }
    
    @IBOutlet weak var startGame: UIButton!
    
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
        collectionViewLayout.sectionHeadersPinToVisibleBounds = true
        self.collectionView.setCollectionViewLayout(collectionViewLayout,
                                                    animated: false)
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self.adapterDataSource
    }
    
}

extension HomeViewController: HomeView {
    
    func configure(listObjects: [ListDiffable]) {
        self.adapterDataSource.listObjects = listObjects
    }

}
