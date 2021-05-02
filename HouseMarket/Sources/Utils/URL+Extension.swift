//
//  URL+Extension.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import Foundation

public extension URL {
    init?(string: String?) {
        guard let string = string else {
            return nil
        }
        self.init(string: string)
    }
}
