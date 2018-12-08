//
//  GameCell.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {

    static let height: CGFloat = 50.0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(partnerName: String?, timeLeft: String? = nil) {
        self.titleLabel.text = partnerName
        self.timeLeftLabel.text = timeLeft
    }

}
