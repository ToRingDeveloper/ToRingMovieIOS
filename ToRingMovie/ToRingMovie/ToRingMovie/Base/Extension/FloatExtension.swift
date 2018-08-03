//
//  IntegerExtension.swift
//  ToRingMovie
//
//  Created by TR on 8/2/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

extension Float {
    func formatForCurrency() -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedCurency = formatter.string(from: self as NSNumber) {
            return formattedCurency
        }
        return "\(self)"
    }
    
    func formatWithSeparator() ->String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter.string(for: self) ?? ""
    }
}

