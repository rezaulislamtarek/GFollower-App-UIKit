//
//  GFItemInfoView.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 18/6/24.
//

import UIKit
import SnapKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let itemLabel = GFTitleLabel(textAlignment: .left, fontSize: 22)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 22)
    
    private var views : [UIView] = []
     
    override init(frame: CGRect) {
        super.init(frame: frame)
       configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure(){
        // add views
        views = [symbolImageView, itemLabel, countLabel]
        addViews()
        configViews()
    }
    
    private func addViews(){
        views.forEach { v in
            addSubview(v)
        }
    }
    private func configViews(){
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        itemLabel.snp.makeConstraints { make in
            make.left.equalTo(symbolImageView.snp.right).offset(16)
            make.trailing.equalTo(snp.trailing)
            make.centerY.equalTo(symbolImageView)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(itemLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(snp.trailing)
        }
        
    }
    
    func set(itemInfoType : ItemInfoType, withCount count: Int){
        switch itemInfoType{
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSymbols.repos)
            itemLabel.text = "Public Repos"
             
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymbols.gists)
            itemLabel.text = "Gists"
            
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.followers)
            itemLabel.text = "Followers"
            
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
            itemLabel.text = "Following"
            
        }
        countLabel.text = String(count)
    }

}

 
