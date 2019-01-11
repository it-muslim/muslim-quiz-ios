//
//  RoundFoouterCell.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 16/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol RoundFooterDelegate : class {
    
    func skip()
    func report()
    
}

class RoundFooterCell: UICollectionViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    
    lazy var buttonSkip: UIButton = {
        let button = self.button()
        button.setAttributedTitle(RoundFooterCell.attirbutedReportSkip(),
                                  for: .normal)
        button.addTarget(self, action: #selector(RoundFooterCell.skip), for: .touchUpInside)
        return button
    }()
    lazy var buttonReport: UIButton = {
        let button = self.button()
        button.setAttributedTitle(RoundFooterCell.attirbutedReportTitle(),
                                  for: .normal)
        button.addTarget(self, action: #selector(RoundFooterCell.report), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: RoundFooterDelegate?
    
    static func height() -> CGFloat {
        return 100
    }
    
    func configure(roundStatus: RoundStatus) {
        self.stackView.subviews.forEach { (button) in
            self.stackView.removeArrangedSubview(button)
        }
        switch roundStatus.status {
        case .playing:
            self.stackView.addArrangedSubview(self.buttonSkip)
            self.stackView.addArrangedSubview(self.buttonReport)
            break
        case .waiting: fallthrough
        case .finished: 
            self.stackView.addArrangedSubview(self.buttonReport)
            break
        }
    }
    
    //MARK: Private
    
    @objc private func skip() {
        self.delegate?.skip()
    }
    
    @objc private func report() {
        self.delegate?.report()
    }
    
    static private func attirbutedReportSkip() -> NSAttributedString {
        let text = "Пропустить"
        return NSAttributedString(string: text, attributes: nil)
    }
    
    static private func attirbutedReportTitle() -> NSAttributedString {
        let text = "Нашли ошибку? Сообщите нам"
        return NSAttributedString(string: text, attributes: nil)
    }
    
    //TODO: Replace with fabric
    private func button() -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitleColor(.blue, for: .normal)
        button.setBackgroundImage(UIImage.from(color: .gray), for: .normal)
        return button
    }
    
}
