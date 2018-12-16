//
//  RoundAnswerCell.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 15/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

class RoundAnswerCell: UICollectionViewCell {
    fileprivate static let AnswerTitleInset = UIEdgeInsets(top: 15,
                                                    left: 15,
                                                    bottom: 15,
                                                    right: 15)
    @IBOutlet weak var titleLabel: UILabel!
    
    static func height(for answer: Answer, with width: CGFloat) -> CGFloat {
        let text = answer.content["text"] ?? ""
        let attirbutedTitle = RoundAnswerCell.attirbutedTitle(text: text)
        
        let width = width - AnswerTitleInset.left - AnswerTitleInset.right
        let size = CGSize(width: width, height: 1000)
        let rect = attirbutedTitle.boundingRect(with: size,
                                                options: [.usesFontLeading, .usesLineFragmentOrigin],
                                                context: nil)

        return rect.height + AnswerTitleInset.top + AnswerTitleInset.bottom
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(answer: Answer) {
        let text = answer.content["text"] ?? ""
        self.titleLabel.attributedText = RoundAnswerCell.attirbutedTitle(text: text)
    }
    
    //MARK: Private
    
    static func attirbutedTitle(text: String) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: nil)
    }

}
