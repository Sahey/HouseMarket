//
//  PropertyListPresenter.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import Foundation

protocol PropertyListPresenterProtocol {
    func present(data: PropertyList.Data)
    func present(error: Error)
}

final class PropertyListPresenter: PropertyListPresenterProtocol {
    typealias Data = PropertyList.Data
    typealias CellViewModel = PropertyList.ViewModel.Cell
    typealias AlertViewModel = PropertyList.ViewModel.Alert

    private let mapper: PropertyMapperProtocol

    weak var viewController: PropertyListViewControllerProtocol?

    init(mapper: PropertyMapperProtocol) {
        self.mapper = mapper
    }

    private func toViewModle(area: Data.Area) -> MunicipalityViewModel {
        MunicipalityViewModel(
            id: area.id,
            title: NSLocalizedString("PROPERTY_LIST_AREA", comment: ""),
            city: area.area,
            rating: String(format: NSLocalizedString("PROPERTY_LIST_RATE", comment: ""), "\(area.rating)"),
            imageUrl: URL(string: area.image),
            averagePrice: String(format: NSLocalizedString("PROPERTY_LIST_AVERAGE_PRICE", comment: ""), "\(area.averagePrice)")
        )
    }

    private func toViewModel(item: Data.Item) -> CellViewModel {
        switch item {
        case let .property(data):
            let viewModel = mapper.map(property: data, isHighlighted: false)
            return .property(viewModel: viewModel)
        case let .highlightedProperty(data):
            let viewModel = mapper.map(property: data, isHighlighted: true)
            return .property(viewModel: viewModel)
        case let .area(data):
            let viewModel = toViewModle(area: data)
            return .municipality(viewModel: viewModel)
        }
    }

    func present(data: PropertyList.Data) {
        let cellViewModels = data.items.map(toViewModel)
        let viewModel = PropertyList.ViewModel.data(cells: cellViewModels)
        DispatchQueue.main.async {
            self.viewController?.show(viewModel: viewModel)
        }
    }

    func present(error: Error) {
        let viewModel = AlertViewModel(
            title: "Something went wrong",
            message: error.localizedDescription,
            retry: "Retry",
            cancel: "Cancel"
        )
        DispatchQueue.main.async {
            self.viewController?.show(viewModel: .failure(alert: viewModel))
        }
    }
}
