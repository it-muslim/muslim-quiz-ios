//
//  RoundHeaderCell.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 15/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol RoundHeaderDelegate: class {
    
    func giveUp()
    
}

class RoundHeaderCell: UICollectionViewCell {

    fileprivate static let RoundHeaderBasicHeight : CGFloat = 45.0
    fileprivate static let RoundHeaderTitleInset = UIEdgeInsets(top: 15,
                                                           left: 15,
                                                           bottom: 15,
                                                           right: 15)
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate : RoundHeaderDelegate?
    
    static func height(for roundSummary: Round.RoundSummary, with width: CGFloat) -> CGFloat {
        let attirbutedTitle = RoundHeaderCell.attirbutedTitle(text: roundSummary.title)
        let width = width - RoundHeaderTitleInset.left - RoundHeaderTitleInset.right
        let size = CGSize(width: width, height: 1000)
        let rect = attirbutedTitle.boundingRect(with: size,
                                                options: [.usesFontLeading, .usesLineFragmentOrigin],
                                                context: nil)
        
        return rect.height
            + RoundHeaderTitleInset.top
            + RoundHeaderTitleInset.bottom
            + RoundHeaderBasicHeight
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(roundSummary: Round.RoundSummary) {
        self.pageControl.numberOfPages = roundSummary.questionCount
        self.pageControl.currentPage = roundSummary.questionIndex
        self.titleLabel.attributedText = RoundHeaderCell.attirbutedTitle(text: roundSummary.title)
    }

    @IBAction func giveUp(_ sender: Any) {
        self.delegate?.giveUp()
    }
    
    //MARK: Private
    
    static private func attirbutedTitle(text: String) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: nil)
    }
    
}
