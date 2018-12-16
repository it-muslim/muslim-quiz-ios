//
//  RoundProgressCell.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 15/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

class RoundProgressCell: UICollectionViewCell {

    @IBOutlet weak var progressView: UIProgressView!
    
    static var height : CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(progress: Float?) {
        self.progressView.progress = progress ?? 0
    }

}
