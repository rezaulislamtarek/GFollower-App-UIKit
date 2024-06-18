//
//  UserInfoVC.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 9/6/24.
//

import UIKit

class UserInfoVC: UIViewController {
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var userName : String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureViewController()
        getUserInfo(userName: userName)
        configure()
        
    }
    
    private func configure(){
        configHeaderView()
        configViewOne()
        configViewTwo()
    }
    
    private func configHeaderView(){
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview( )
            make.height.equalTo(180)
        }
    }
    
    private func configViewOne(){
        view.addSubview(itemViewOne)
        
        //itemViewOne.backgroundColor = .systemPink
        itemViewOne.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
                .offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(160)
            
        }
        
       
    }
    
    private func configViewTwo(){
        view.addSubview(itemViewTwo)
        
        //itemViewTwo.backgroundColor = .systemPink
        
        itemViewTwo.snp.makeConstraints { make in
            make.top.equalTo(itemViewOne.snp.bottom)
                .offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(160)
        }
      
        
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    private func getUserInfo(userName : String){
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemVC(user: user), to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemVC(user: user), to: self.itemViewTwo)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, butttonTitle: "Ok")
            }
        }
    }
    
    private func add(childVC: UIViewController, to containerView : UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    }
     
}
