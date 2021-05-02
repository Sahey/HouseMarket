//
//  PropertySearchAssembly.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import Swinject

final class PropertySearchAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PropertySearchServiceProtocol.self) { _ in
            PropertySearchServiceMock()
        }
    }
}
