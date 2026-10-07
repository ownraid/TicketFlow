//
//  AppColors.swift
//  TicketFlow
//
//  Created by Own on 24/09/2026.
//

import UIKit

extension UIColor {

    static var primary: UIColor {
        UIColor(
            red: 206.0 / 255.0,
            green: 47.0 / 255.0,
            blue: 34.0 / 255.0,
            alpha: 1
        )
    }
    
    static var unSelcted: UIColor {
        UIColor(
            red: 249.0 / 255.0,
            green: 250.0 / 255.0,
            blue: 252.0 / 255.0,
            alpha: 1
        )
    }
    
    static var closed: UIColor = UIColor.systemRed.withAlphaComponent(0.12)
    static var resolved: UIColor = UIColor.systemGreen.withAlphaComponent(0.12)
}
