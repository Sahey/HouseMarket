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

    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()

    private let measurementFormatter: MeasurementFormatter = {
        let measurementFormatter = MeasurementFormatter()

        return measurementFormatter
    }()

    weak var viewController: PropertyListViewControllerProtocol?

    private func toViewModle(property: Data.Property, isHighlighted: Bool) -> PropertyViewModel {
        PropertyViewModel(
            id: 0,
            imageUrl: URL(string: property.image),
            isPremium: isHighlighted,
            address: property.streetAddress,
            municipality: property.municipality,
            price: property.askingPrice,
            livingArea: pretify(squareMetres: property.livingArea),
            numberOfRooms: String(format: NSLocalizedString("PROPERTY_LIST_ROOMS", comment: ""), pretify(double: property.numberOfRooms)),
            daysPosted: pretify(days: property.daysOnHemnet)
        )
    }

    private func pretify(squareMetres: Double) -> String {
        let measurement = Measurement(value: squareMetres, unit: UnitArea.squareMeters)
        return measurementFormatter.string(from: measurement)
    }

    private func pretify(days: Int) -> String {
        let formatString: String = NSLocalizedString("REMAINING_DAY_PATTERN", comment: "")
        let resultString = String.localizedStringWithFormat(formatString, days)
        return resultString
    }

    private func pretify(double: Double) -> String {
        let number = NSNumber(value: double)
        return numberFormatter.string(from: number) ?? "\(double)"
    }

    private func toViewModle(area: Data.Area) -> MunicipalityViewModel {
        MunicipalityViewModel(
            id: 0,
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
