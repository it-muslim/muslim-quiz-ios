//
//  GameFooterCell.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol GameFooterDelegate: class {
    
    func giveUp()
    func play()
    func rematch()
    
}

class GameFooterCell: UICollectionViewCell {

    @IBOutlet weak var stackView: UIStackView!
    weak var delegate: GameFooterDelegate?
    
    static let height: CGFloat = 124.0
    
    lazy var buttonPlay: UIButton = {
        let button = self.button()
        button.setTitle("Играть", for: .normal)
        button.addTarget(self, action: #selector(GameFooterCell.play), for: .touchUpInside)
        return button
    }()
    lazy var buttonGiveUp: UIButton = {
        let button = self.button()
        button.setTitle("Сдаться", for: .normal)
        button.addTarget(self, action: #selector(GameFooterCell.giveUp), for: .touchUpInside)
        return button
    }()
    lazy var buttonRematch: UIButton = {
        let button = self.button()
        button.setTitle("Реванш", for: .normal)
        button.addTarget(self, action: #selector(GameFooterCell.rematch), for: .touchUpInside)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(gameStatus: GameStatus) {
        self.stackView.subviews.forEach { (button) in
            self.stackView.removeArrangedSubview(button)
        }
        switch gameStatus.status {
        case .waiting:
            self.stackView.addArrangedSubview(self.buttonGiveUp)
            break
        case .playing:
            self.stackView.addArrangedSubview(self.buttonPlay)
            self.stackView.addArrangedSubview(self.buttonGiveUp)
            break
        case .rejected: fallthrough
        case .finished:
            self.stackView.addArrangedSubview(self.buttonRematch)
            break
        }
    }
    
    //MARK: Private
    
    @objc private func giveUp() {
        self.delegate?.giveUp()
    }
    @objc private func play() {
        self.delegate?.play()
    }
    @objc private func rematch() {
        self.delegate?.rematch()
    }

    //TODO: Replace with fabric
    private func button() -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitleColor(.blue, for: .normal)
        button.setBackgroundImage(UIImage.from(color: .gray), for: .normal)
        return button
    }
    
}
