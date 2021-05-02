//
//  Array+Extension.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

extension Array where Element == String {
    var commaSeparated: String {
        joined(separator: ", ")
    }
}
