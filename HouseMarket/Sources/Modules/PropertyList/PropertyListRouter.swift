//
//  PropertyListRouter.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit

protocol PropertyListRouterProtocol {
    func routeToDetails(property: PropertySearch.Response.Property, isHighlihted: Bool)
}

final class PropertyListRouter: PropertyListRouterProtocol {
    private let propertyDetailsBuilder: PropertyDetailBuilderProtocol
    weak var viewController: UIViewController?

    init(propertyDetailsBuilder: PropertyDetailBuilderProtocol) {
        self.propertyDetailsBuilder = propertyDetailsBuilder
    }

    func routeToDetails(property: PropertySearch.Response.Property, isHighlihted: Bool) {
        guard let navigationController = viewController?.navigationController else { return }
        let details = propertyDetailsBuilder.build(input: PropertyDetail.Input(property: property, isHighlighted: isHighlihted))
        navigationController.pushViewController(details, animated: true)
    }
}
