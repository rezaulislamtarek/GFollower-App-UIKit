//
//  GFAvatarImageView.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 7/6/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(systemName: "person")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
