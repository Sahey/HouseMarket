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
    func build() -> UIViewController {
        let presenter = PropertyListPresenter()
        let interactor = MockPropertyListInteractor(presenter: presenter)
        let viewController = PropertyListViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
