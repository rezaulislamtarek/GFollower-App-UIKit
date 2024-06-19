//
//  Date+Extension.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 19/6/24.
//

import Foundation

extension Date {
    func convertToMonthYearFormate() -> String{
        let dateFormator = DateFormatter()
        dateFormator.dateFormat = "MMM YYYY"
        return dateFormator.string(from: self)
    }
}
