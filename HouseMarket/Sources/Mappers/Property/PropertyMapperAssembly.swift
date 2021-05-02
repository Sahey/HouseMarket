//
//  PropertyMapperAssembly.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import Swinject

final class PropertyMapperAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PropertyMapperProtocol.self) { _ in
            PropertyMapper()
        }
    }
}
