//
//  GFButton.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 4/6/24.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    init(backgroundColor: UIColor, title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func configure(){
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    func set(backgroundcolor: UIColor, title: String){
        self.backgroundColor = backgroundcolor
        setTitle(title, for: .normal)
    }
    
}

#Preview{
    GFButton(backgroundColor: .systemPink, title: "Title")
}
