//
//  PropertyListBuilder.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit

protocol PropertyListBuilderProtocol: AnyObject {
    func build() -> UIViewController
}

final class PropertyListBuilder: PropertyListBuilderProtocol {
    private let service: PropertySearchServiceProtocol
    private let mapper: PropertyMapperProtocol
    private let propertyDetailsBuilder: PropertyDetailBuilderProtocol

    init(
        service: PropertySearchServiceProtocol,
        mapper: PropertyMapperProtocol,
        propertyDetailsBuilder: PropertyDetailBuilderProtocol
    ) {
        self.service = service
        self.mapper = mapper
        self.propertyDetailsBuilder = propertyDetailsBuilder
    }

    func build() -> UIViewController {
        let router = PropertyListRouter(propertyDetailsBuilder: propertyDetailsBuilder)
        let presenter = PropertyListPresenter(mapper: mapper)
        let interactor = PropertyListInteractor(
            presenter: presenter,
            service: service,
            router: router
        )
        let viewController = PropertyListViewController(interactor: interactor)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
