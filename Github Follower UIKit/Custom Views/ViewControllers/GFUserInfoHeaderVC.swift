//
//  GFUserInfoHeaderVC.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 14/6/24.
//

import UIKit
import SnapKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)
     
    var user : User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configUIElements()
         
    }
    

    private func configure(){
        configAvatarImageView()
        configUsernameLabel()
        configNameLabel()
        configLocationImageView()
        configLocationLabel()
        configBioLabel()
    }
    
    private func configUIElements(){
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        
    }
    
    private func configAvatarImageView(){
        view.addSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(100)
            make.width.equalTo(100)
            
        }
    }
    
    private func configUsernameLabel(){
        view.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.top)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
        }
    }
    
    private func configNameLabel(){
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom)
            make.left.equalTo(usernameLabel.snp.left)
            
        }
    }
    
    private func configLocationImageView(){
        view.addSubview(locationImageView)
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        locationImageView.snp.makeConstraints { make in
            make.bottom.equalTo(avatarImageView.snp.bottom)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
        }
    }
    
    private func configLocationLabel(){
        view.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.left.equalTo(locationImageView.snp.right).offset(8)
            make.centerY.equalTo(locationImageView)
        }
    }
    
    private func configBioLabel(){
        view.addSubview(bioLabel)
        
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.left.equalTo(avatarImageView.snp.left)
            make.right.equalToSuperview()
            make.height.equalTo(60)
        }
    }
  

}
