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
        NetworkManager.shared.getFollowers(for: userName, page: 1) { followers, error in
            if let fol = followers{
                print(fol)
            }
            if let error = error{
                print(error)
                self.presentGFAlert(title: "Error", message: error, butttonTitle: "Or")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

 

}
