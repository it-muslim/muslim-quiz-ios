//
//  GamesHeaderView.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol GamesHeaderViewDelegate : class {
    func toggleCollapse()
}

class GamesHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    weak var delegate: GamesHeaderViewDelegate?
    
    static let height: CGFloat = 50.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(title: String?,
                   collapsed: Bool) {
        self.titleLabel.text = title
        self.arrowLabel.text = collapsed ? "V" : "^"
    }
    
    @IBAction func toggleCollapse(_ sender: Any) {
        self.delegate?.toggleCollapse()
    }
    
}
