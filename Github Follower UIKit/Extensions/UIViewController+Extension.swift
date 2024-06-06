//
//  UIViewController+Extension.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 6/6/24.
//

import UIKit

extension UIViewController{
    func presentGFAlert(title: String, message: String, butttonTitle: String){
        DispatchQueue.main.async {
            let alertVc = GFAlertVC(alertTitle: title, message: message, buttonTitle: butttonTitle)
            alertVc.modalPresentationStyle = .overFullScreen
            alertVc.modalTransitionStyle = .crossDissolve
            self.present(alertVc, animated: true)
        }
    }
}
