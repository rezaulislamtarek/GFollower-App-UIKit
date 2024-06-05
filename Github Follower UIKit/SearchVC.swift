//
//  SearchVCViewController.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 4/6/24.
//

import UIKit
import SnapKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let appNameLabel = UILabel()
    let usernameTF = GFTextField(placeHolderText: "Enter user name")
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    var isUserNameEntered : Bool {
        return !usernameTF.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configuration()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configuration(){
        configureLogoImageView()
        configAppNameLabel()
        configUserNameTF()
        cofigCallToActionBtn()
        createDismissKeyboardTapGesture()
    }
    
    func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowerListVC(){
        guard isUserNameEntered else {
            presentGFAlert(title: "Empty username", message: "Please enter username. We need to know your name to procede 😎", butttonTitle: "Ok")
            return }
        let followerListVC = FollowerListVC()
        followerListVC.userName = usernameTF.text
        followerListVC.title = usernameTF.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    

     
    private func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "github_logo")?.withRenderingMode(.alwaysTemplate)
        
        logoImageView.layer.cornerRadius = 14
        logoImageView.layer.masksToBounds = true
        logoImageView.tintColor = .label
        logoImageView.contentMode = .scaleAspectFit
        
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
    
    private func configAppNameLabel(){
        view.addSubview(appNameLabel)
        appNameLabel.text = "GitHub \nFollowers"
        appNameLabel.textAlignment = .center
        appNameLabel.numberOfLines = 0
        appNameLabel.lineBreakMode = .byWordWrapping
        appNameLabel.frame.size.width = 150
        appNameLabel.sizeToFit()
        
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 28)
        appNameLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.left).offset(16)
            make.top.equalTo(logoImageView.snp.bottom).offset(16)
            make.right.equalTo(logoImageView.snp.right).inset(16)
             
        }
    }
    
    private func configUserNameTF(){
        view.addSubview(usernameTF)
        usernameTF.delegate = self
        
        usernameTF.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(16)
            make.left.equalTo(appNameLabel.snp.left)
            make.right.equalTo(appNameLabel.snp.right)
            make.height.equalTo(50 )
        }
    }
    
    private func cofigCallToActionBtn(){
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        callToActionButton.snp.makeConstraints { make in
            //make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(60)
            make.left.equalTo(appNameLabel.snp.left)
            make.right.equalTo(appNameLabel.snp.right)
            make.height.equalTo(50)
        }
    }

}

extension SearchVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Did Tap")
        pushFollowerListVC()
        return true
    }
}

#Preview{
    SearchVC()
}
