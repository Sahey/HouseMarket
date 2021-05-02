//
//  PropertyDetailAssembly.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import Swinject

final class PropertyDetailAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PropertyDetailBuilderProtocol.self) {  resolver in
            PropertyDetailBuilder(
                mapper: resolver.resolve(PropertyMapperProtocol.self)!
            )
        }
    }
}
