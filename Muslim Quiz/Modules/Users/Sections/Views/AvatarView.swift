//
//  AvatarView.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit
import SDWebImage

class AvatarView: UIView, NibLoadable {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var statusView: UIView!
    
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
    
    func configure(user: User?) {
        if let avatarUrl = user?.avatarUrl,
            let url = URL(string: avatarUrl) {
            self.imageView?.sd_setImage(with: url,
                                       completed: nil)
        }
        self.statusView.isHidden = user?.online == false
    }
    
    //MARK: Private
    
    func setupViews() {
        self.imageView.layer.cornerRadius = 26.0
        self.imageView.clipsToBounds = true
        self.imageView.backgroundColor = .lightGray
        
        self.statusView.layer.cornerRadius = 6.5
        self.statusView.clipsToBounds = true
        self.statusView.layer.borderColor = UIColor.white.cgColor
        self.statusView.layer.borderWidth = 1.0
    }
    
}
