//
//  RoundResultView.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit
import SnapKit

class RoundResultView: UIView, NibLoadable {
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupFromNib()
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupFromNib()
        self.setupViews()
    }

    func configure(roundUserInfo: RoundUserInfo?) {
        self.stackView.arrangedSubviews.forEach { (view) in
            self.stackView.removeArrangedSubview(view)
        }
        switch roundUserInfo?.status {
        case .some(.text(let status)):
            let textLabel = UILabel()
            textLabel.text = status
            self.stackView.addArrangedSubview(textLabel)
            break
        case .some(.answers(let answers)):
            for answer in answers {
                let view = UIView()
                view.backgroundColor = answer ? .green : .red
                self.stackView.addArrangedSubview(view)
                view.snp.makeConstraints { (make) in
                    make.height.equalToSuperview()
                }
            }
            break
        case .none:
            return
        }
    }
    
    //MARK: Private
    
    private func setupViews() {
        
    }
    
}
