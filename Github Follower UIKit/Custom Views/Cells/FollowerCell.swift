//
//  FollowerCellCollectionViewCell.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 7/6/24.
//

import UIKit
import SnapKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userNameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower){
        userNameLabel.text = follower.login
    }
    
    private func configure(){
        configAvatar()
        configLabel()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configAvatar(){
        addSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
    }
    
    private func configLabel(){
        addSubview(userNameLabel)
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.leading.equalTo(avatarImageView.snp.leading)
            make.trailing.equalTo(avatarImageView.snp.trailing)
        }
    }
}


