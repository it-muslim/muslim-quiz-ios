//
//  RoundResultView.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit
import SnapKit

class GameSummaryCell: UICollectionViewCell {
    
    @IBOutlet weak var userAvatarView: AvatarView!
    @IBOutlet weak var partnerAvatarView: AvatarView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    static let height: CGFloat = 102.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }

    func configure(gameSummary: Game.Summary) {
        self.userAvatarView.configure(user: gameSummary.userInfo.user)
        self.partnerAvatarView.configure(user: gameSummary.partnerInfo.user)
        
        self.scoreLabel.text = "\(gameSummary.userInfo.score) : \(gameSummary.partnerInfo.score)"
    }
    
    //MARK: Private
    
    private func setupViews() {
        
    }
    
}
