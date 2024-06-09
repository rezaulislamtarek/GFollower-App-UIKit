//
//  UserInfoVC.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 9/6/24.
//

import UIKit

class UserInfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }

     
}
