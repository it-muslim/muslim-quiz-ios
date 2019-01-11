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
        self.titleLabel.text = "Раунд \(round)"
        self.topicLabel.text = round.topic.name
        
        let currentUserInfo = round.userInfos.filter { $0.user == round.currentUser }.first
        self.userRoundUserView.configure(roundUserInfo: currentUserInfo)
        
        //TODO: Make UI to show all partners
        let partnerUserInfo = round.userInfos.filter { $0.user != round.currentUser }.first
        self.partnerRoundUserView.configure(roundUserInfo: partnerUserInfo)
    }

    //MARK: Private
    
    private func setupViews() {
        
    }
    
}
