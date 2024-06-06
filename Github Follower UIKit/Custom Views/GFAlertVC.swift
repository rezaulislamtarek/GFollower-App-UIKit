//
//  GFAlertVCViewController.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 5/6/24.
//

import UIKit
import SnapKit

class GFAlertVC: UIViewController {

    let containerView = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle  : String?
    var message : String?
    var buttonTitle : String?
    
    init(alertTitle: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configure()
    }
     
    private func configure(){
        configContainerView()
        configTitleLabel()
        configMessageLabel()
        configActionButton()
    }
    
    private func configContainerView(){
        view.addSubview(containerView)
        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .systemBackground
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 2
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(200)
        }
    }
    
    private func configTitleLabel(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configMessageLabel(){
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complite request"
        messageLabel.numberOfLines = 4
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            
        }
    }
    
    private func configActionButton(){
        containerView.addSubview(actionButton)
        
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        actionButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
    @objc private func dismissVC(){
        dismiss(animated: true)
    }
}


#Preview{
    GFAlertVC(alertTitle: "Alert title", message: "Alert message should be show here.Alert message should be show here." )
}
