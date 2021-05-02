//
//  DesignText.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

public enum DesignText {
    case header(style: Header)
    case paragraph(style: Paragraph)
}

// MARK: - Header

public extension DesignText {
    enum Header {
        case h1, h2, h3
    }
}

// MARK: - Paragraph

public extension DesignText {
    enum Paragraph {
        case p1, p2
    }
}
