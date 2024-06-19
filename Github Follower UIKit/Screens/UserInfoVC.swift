//
//  UserInfoVC.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 9/6/24.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate : class{
    func didTapGithubProfile(user : User)
    func didTapGetFollowers(user : User)
}

class UserInfoVC: UIViewController {
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
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
        configDateLabel()
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
    
    private func configDateLabel(){
        view.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(itemViewTwo.snp.bottom)
            make.centerX.equalToSuperview()
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
                DispatchQueue.main.async { self.configureUIElements(with: user)  }
            case .failure(let error):
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, butttonTitle: "Ok")
            }
        }
    }
    
    private func configureUIElements( with user: User){
        
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        
        
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormate())"
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


extension UserInfoVC : UserInfoVCDelegate{
    func didTapGithubProfile(user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlert(title: "Invalid URL", message: "Url is invalid", butttonTitle: "Ok")
            return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true )
    }
    
    func didTapGetFollowers(user: User) {
        
    }
    
    
    
    
}
