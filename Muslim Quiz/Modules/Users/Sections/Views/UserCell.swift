//
//  UserCell.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

class UserCell : UICollectionViewCell {
    
    static let height: CGFloat = 72.0
    
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var avatarView: AvatarView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    func configure(number: Int, user: User) {
        self.numberLabel.text = "\(number)"
        self.nameLabel.text = user.fullName
        self.avatarView.configure(user: user)
        self.levelLabel.text = user.level
        self.scoreLabel.text = "\(user.score)"
    }
    
}
