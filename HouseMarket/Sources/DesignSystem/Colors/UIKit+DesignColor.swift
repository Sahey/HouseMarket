//
//  UIKit+DesignColor.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit

public extension UIColor {
    static func designColor(_ style: DesignColor) -> UIColor {
        switch style {
        case let .background(style):
            return UIColor(named: style.description)!
        case let .constant(style):
            return UIColor(named: style.description)!
        case let .text(style):
            return UIColor(named: style.description)!
        }
    }
}
