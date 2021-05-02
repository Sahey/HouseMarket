//
//  UIKit+DesignText.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit

extension UIFont {
    public static func design(_ style: DesignText) -> UIFont {
        switch style {
        case let .header(style):
            return design(header: style)
        case let .paragraph(style):
            return design(paragraph: style)
        }
    }

    private static func design(header: DesignText.Header) -> UIFont {
        switch header {
        case .h1:
            return UIFont.systemFont(ofSize: 16, weight: .heavy)
        case .h2:
            return UIFont.systemFont(ofSize: 14, weight: .bold)
        case .h3:
            return UIFont.systemFont(ofSize: 12, weight: .bold)
        }
    }

    private static func design(paragraph: DesignText.Paragraph) -> UIFont {
        switch paragraph {
        case .p1:
            return UIFont.systemFont(ofSize: 14, weight: .medium)
        case .p2:
            return UIFont.systemFont(ofSize: 12, weight: .regular)
        }
    }
}
