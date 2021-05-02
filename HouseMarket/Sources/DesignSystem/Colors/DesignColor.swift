//
//  DesignColor.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

public enum DesignColor: CustomStringConvertible {
    case background(style: Background)
    case constant(style: Constant)
    case text(style: Text)

    public var description: String {
        switch self {
        case let .background(style):
            return style.description
        case let .constant(style):
            return style.description
        case let .text(style):
            return style.description
        }
    }
}

// MARK: - Backgrounds

public extension DesignColor {
    enum Background: CustomStringConvertible, CaseIterable {
        case primary

        public var description: String {
            switch self {
            case .primary:
                return "Colors/Backgrounds/Primary"
            }
        }
    }
}

// MARK: - Constants

public extension DesignColor {
    enum Constant: CustomStringConvertible, CaseIterable {
        case brand, premium

        public var description: String {
            switch self {
            case .brand:
                return "Colors/Constants/Brand"
            case .premium:
                return "Colors/Constants/Premium"
            }
        }
    }
}

// MARK: - Text

public extension DesignColor {
    enum Text: CustomStringConvertible, CaseIterable {
        case primary, secondary, primaryReversed

        public var description: String {
            switch self {
            case .primary:
                return "Colors/Texts/Primary"
            case .secondary:
                return "Colors/Texts/Secondary"
            case .primaryReversed:
                return "Colors/Texts/PrimaryReversed"
            }
        }
    }
}
