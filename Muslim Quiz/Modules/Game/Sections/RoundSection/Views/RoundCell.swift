//
//  RoundCell.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

class RoundCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var userRoundUserView: RoundResultView!
    @IBOutlet weak var partnerRoundUserView: RoundResultView!
    
    static let height: CGFloat = 38.5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    func configure(number:Int, round: Round) {
        self.titleLabel.text = "Рвунд \(round)"
        self.topicLabel.text = round.topic.name
        self.userRoundUserView.configure(roundUserInfo: round.roundUserInfo)
        self.partnerRoundUserView.configure(roundUserInfo: round.roundPartnerInfo)
    }

    //MARK: Private
    
    private func setupViews() {
        
    }
    
}
