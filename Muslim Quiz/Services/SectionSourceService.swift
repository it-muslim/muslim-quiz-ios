//
//  SectionSourceService.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit.IGListAdapterDataSource

protocol SectionSourceServiceProtocol: ListAdapterDataSource{
    
    var listObjects: [ListDiffable] {get set}
}

class SectionSourceService: NSObject, SectionSourceServiceProtocol {
    
    var listObjects: [ListDiffable]
    
    init(listObjects: [ListDiffable] = [ListDiffable]()) {
        self.listObjects = listObjects
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.listObjects
    }
    
    func listAdapter(_ listAdapter: ListAdapter,
                     sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case let gameSection as GameSection:
            return GameSectionController(gameSection: gameSection)
        case let user as User:
            return UserSectionController(user: user)
        case let round as Round:
            return RoundSectionController(round: round)
        case let gameSummary as Game.Summary:
            return GameHeaderSectionController(gameSummary: gameSummary)
        case let gameStatus as Game.Status:
            return GameFooterSectionController(gameStatus: gameStatus)
        default:
            fatalError("No ListSectionController provided for \(type(of: object))")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        //TODO: Replace with normal empty view
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }
    
}
