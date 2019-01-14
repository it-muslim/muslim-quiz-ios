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

    func configure(gameSummary: GameSummary) {
        // TODO: Add more that 2 users here
        self.userAvatarView.configure(user: gameSummary.userInfos.first?.user)
        self.partnerAvatarView.configure(user: gameSummary.userInfos.last?.user)
        self.scoreLabel.text = "\(gameSummary.userInfos[0].score) : \(gameSummary.userInfos[1].score)"
    }
    
    //MARK: Private
    
    private func setupViews() {
        
    }
    
}
