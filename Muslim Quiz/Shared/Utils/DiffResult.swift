//
//  DiffUtility.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 06/01/2019.
//  Copyright @danielgalasko https://github.com/Instagram/IGListKit/issues/35
//

import IGListKit

/**
 Performs a diff operation between two sets of `ItemDiffable` results.
 */
public struct DiffResult {
    
    public typealias Move = (from: Int, to: Int)
    public let inserts: [Int]
    public let deletions: [Int]
    public let updates: [Int]
    public let moves: [Move]
    
    public let oldIndexForID: (_ id: String) -> Int
    public let newIndexForID: (_ id: String) -> Int

    public static func diff(originalItems: [Diffable], newItems: [Diffable]) -> DiffResult {
        let old = originalItems.map { DiffableBox(value: $0) }
        let new = newItems.map { DiffableBox(value: $0) }
        let result = ListDiff(oldArray: old,
                              newArray: new,
                              option: .equality)
        
        let inserts = Array(result.inserts)
        let deletions = Array(result.deletes)
        let updates = Array(result.updates)
        let moves: [DiffResult.Move] = result.moves.map({ (from: $0.from, to: $0.to) })
        
        let oldIndexForID: (_ id: String) -> Int = { id in
            return result.oldIndex(forIdentifier: NSString(string: id))
        }
        let newIndexForID: (_ id: String) -> Int = { id in
            return result.newIndex(forIdentifier: NSString(string: id))
        }
        return DiffResult(inserts: inserts,
                          deletions: deletions,
                          updates: updates,
                          moves:moves,
                          oldIndexForID: oldIndexForID,
                          newIndexForID: newIndexForID)
    }
}
