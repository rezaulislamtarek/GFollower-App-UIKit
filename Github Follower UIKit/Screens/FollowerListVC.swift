//
//  FollowerListVCViewController.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 5/6/24.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var userName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
            switch result{
            case .success(let followers):
                print(followers.count)
            case .failure(let error):
                self.presentGFAlert(title: "Error", message: error.rawValue, butttonTitle: "Ok")
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
}
