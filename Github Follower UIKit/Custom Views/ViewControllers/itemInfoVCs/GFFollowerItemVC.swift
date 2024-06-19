//
//  GFFollowerItemVC.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 19/6/24.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    private func configureItems(){
        itemInfoOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundcolor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(user: user)
    }
    
    
}
