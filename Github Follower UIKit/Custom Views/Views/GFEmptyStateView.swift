//
//  GFEmptyStateView.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 8/6/24.
//

import UIKit
import SnapKit

class GFEmptyStateView: UIView {

    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    init(message : String){
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        configLabel()
        configLogoImage()
    }
    
    private func configLabel(){
        addSubview(messageLabel)
        messageLabel.numberOfLines = 3
        messageLabel.textColor  = .secondaryLabel
    
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
    }
    private func configLogoImage(){
        addSubview(logoImageView)
        logoImageView.image = UIImage(systemName: "person.3.fill")
        logoImageView.tintColor = .systemGreen
        
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(200)
            make.trailing.equalToSuperview().offset(70)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}

#Preview{
    GFEmptyStateView(message: "This user doesn't have any followers. Go follow them 😎")
}
