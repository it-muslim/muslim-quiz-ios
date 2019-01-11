//
//  DiffableBox.swift
//  QuizKit
//
//  Created by Amin Benarieb on 23/12/2018.
//  Copyright © https://github.com/Instagram/IGListKit/issues/35#issuecomment-277503724
//

import Foundation
import IGListKit.IGListDiffable

/**
 A diffable value type that can be used in conjunction with
 `DiffUtility` to perform a diff between two result sets.
 */
public protocol Diffable {
    
    /**
     Returns a key that uniquely identifies the object.
     
     - returns: A key that can be used to uniquely identify the object.
     - note: Two objects may share the same identifier, but are not equal.
     - warning: This value should never be mutated.
     */
    var diffIdentifier: String { get }
    
    /**
     Returns whether the receiver and a given object are equal.
     
     @param object The object to be compared to the receiver.
     
     @return `YES` if the receiver and object are equal, otherwise `NO`.
     */
    func isEqual(toDiffableObject object: Diffable?) -> Bool

}

extension Diffable {
    
    func diffable() -> DiffableBox {
        return DiffableBox(value: self)
    }
}


/// Diffable mappers to ListDiffable
public final class DiffableBox: ListDiffable {
    
    let value: Diffable
    let type : Any.Type
    
    init(value: Diffable) {
        self.value = value
        self.type = Mirror(reflecting: value).subjectType
    }
    
    // ListDiffable
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self.value.diffIdentifier as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let other = object as? DiffableBox {
            return self.value.isEqual(toDiffableObject: other.value)
        }
        return false
    }
}
