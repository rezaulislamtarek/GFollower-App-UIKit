//
//  GFItemInfoVC.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 19/6/24.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoOne = GFItemInfoView()
    let itemInfoTwo = GFItemInfoView()
    let actionButton = GFButton()
    
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
        configureBackgroundView()
        layoutUI()
        configureStatckView()
    }
    
    private  func configureBackgroundView(){
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStatckView(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoOne)
        stackView.addArrangedSubview(itemInfoTwo)
        
    }
    
    private func layoutUI(){
        let padding: CGFloat = 16
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.left.equalToSuperview().offset(padding)
            make.right.equalToSuperview().inset (padding)
            make.height.equalTo(50)
        }
        
        actionButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(padding)
            make.left.equalToSuperview().offset(padding)
            make.right.equalToSuperview().inset (padding)
            make.height.equalTo(44)
        }
    }
    
 

}
