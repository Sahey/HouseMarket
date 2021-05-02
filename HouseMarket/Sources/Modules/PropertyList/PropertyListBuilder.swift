//
//  PropertyListBuilder.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit

protocol PropertyListBuilderProtocol {
    func build() -> UIViewController
}

final class PropertyListBuilder: PropertyListBuilderProtocol {
    private let service: PropertySearchServiceProtocol

    init(service: PropertySearchServiceProtocol) {
        self.service = service
    }

    func build() -> UIViewController {
        let presenter = PropertyListPresenter()
        let interactor = PropertyListInteractor(
            presenter: presenter,
            service: service
        )
        let viewController = PropertyListViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
