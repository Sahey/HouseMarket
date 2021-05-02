//
//  PropertyDetailBuilder.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit

protocol PropertyDetailBuilderProtocol {
    func build(input: PropertyDetail.Input) -> UIViewController
}

final class PropertyDetailBuilder: PropertyDetailBuilderProtocol {
    private let mapper: PropertyMapperProtocol

    init(mapper: PropertyMapperProtocol) {
        self.mapper = mapper
    }

    func build(input: PropertyDetail.Input) -> UIViewController {
        let presenter = PropertyDetailPresenter(mapper: mapper)
        let interactor = PropertyDetailInteractor(
            data: PropertyDetail.Data(
                property: input.property,
                isHighlighted: input.isHighlighted
            ),
            presenter: presenter
        )
        let viewController = PropertyDetailViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
