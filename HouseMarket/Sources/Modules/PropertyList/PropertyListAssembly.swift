//
//  PropertyListAssembly.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import Swinject

final class PropertyListAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PropertyListBuilderProtocol.self) { resolver in
            PropertyListBuilder(
                service: resolver.resolve(PropertySearchServiceProtocol.self)!,
                mapper: resolver.resolve(PropertyMapperProtocol.self)!,
                propertyDetailsBuilder: resolver.resolve(PropertyDetailBuilderProtocol.self)!
            )
        }
    }
}
