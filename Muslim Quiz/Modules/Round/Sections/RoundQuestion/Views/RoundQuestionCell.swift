//
//  RoundQuestionCell.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 15/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

class RoundQuestionCell: UICollectionViewCell {

    fileprivate static let QuestionTitleInset = UIEdgeInsets(top: 15,
                                                           left: 15,
                                                           bottom: 15,
                                                           right: 15)
    @IBOutlet weak var titleLabel: UILabel!
    
    static func height(for question: Question, with width: CGFloat) -> CGFloat {
        let text = question.content["text"] ?? ""
        let attirbutedTitle = RoundQuestionCell.attirbutedTitle(text: text)
        
        let width = width - QuestionTitleInset.left - QuestionTitleInset.right
        let size = CGSize(width: width, height: 1000)
        let rect = attirbutedTitle.boundingRect(with: size,
                                                options: [.usesFontLeading, .usesLineFragmentOrigin],
                                                context: nil)
        
        return rect.height + QuestionTitleInset.top + QuestionTitleInset.bottom
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(question: Question) {
        let text = question.content["text"] ?? ""
        self.titleLabel.attributedText = RoundQuestionCell.attirbutedTitle(text: text)
    }
    
    //MARK: Private
    
    static private func attirbutedTitle(text: String) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: nil)
    }
    
}
