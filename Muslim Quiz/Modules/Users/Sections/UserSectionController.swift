//
//  UserSectionController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import IGListKit

class UserSectionController: ListSectionController {

    var user : User
    init(user: User) {
        self.user = user
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = self.collectionContext!.dequeueReusableCell(withNibName: "UserCell",
                                                               bundle: Bundle.main,
                                                               for: self,
                                                               at: index) as! UserCell
        cell.configure(number: self.section + 1, user: user)
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width,
                      height: UserCell.height)
    }
    
    override func didUpdate(to object: Any) {
        self.collectionContext!.performBatch(animated: true, updates: { (listBatchContext) in
            self.user = object as! User
        }, completion: nil)
    }
    
    override func didSelectItem(at index: Int) {
        
    }
    
}
