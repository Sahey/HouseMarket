//
//  PropertyListPresenter.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import Foundation

protocol PropertyListPresenterProtocol {
    func present(data: PropertyList.Data)
}

final class PropertyListPresenter: PropertyListPresenterProtocol {
    typealias Data = PropertyList.Data
    typealias CellViewModel = PropertyList.ViewModel.Cell

    weak var viewController: PropertyListViewControllerProtocol?

    private func toViewModle(property: Data.Property, isHighlighted: Bool) -> PropertyViewModel {
        PropertyViewModel(
            id: 0,
            imageUrl: URL(string: property.image),
            isPremium: isHighlighted,
            address: property.streetAddress,
            municipality: property.municipality,
            price: property.askingPrice,
            livingArea: "\(property.livingArea)",
            numberOfRooms: "\(property.numberOfRooms)",
            daysPosted: "\(property.daysOnHemnet)"
        )
    }

    private func toViewModle(area: Data.Area) -> MunicipalityViewModel {
        MunicipalityViewModel(
            id: 0,
            title: "Område",
            city: area.area,
            rating: "Betyg: \(area.rating)",
            imageUrl: URL(string: area.image),
            averagePrice: "Snittpris: \(area.averagePrice)"
        )
    }

    private func toViewModel(item: Data.Item) -> CellViewModel {
        switch item {
        case let .property(data):
            let viewModel = toViewModle(property: data, isHighlighted: false)
            return .property(viewModel: viewModel)
        case let .highlightedProperty(data):
            let viewModel = toViewModle(property: data, isHighlighted: true)
            return .property(viewModel: viewModel)
        case let .area(data):
            let viewModel = toViewModle(area: data)
            return .municipality(viewModel: viewModel)
        }
    }

    func present(data: PropertyList.Data) {
        let cellViewModels = data.items.map(toViewModel)
        let viewModel = PropertyList.ViewModel(cells: cellViewModels)
        DispatchQueue.main.async {
            self.viewController?.show(viewModel: viewModel)
        }
    }
}
