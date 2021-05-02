//
//  PropertyMapper.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import Foundation

protocol PropertyMapperProtocol {
    func map(property: PropertySearch.Response.Property, isHighlighted: Bool) -> PropertyViewModel
}

struct PropertyMapper: PropertyMapperProtocol {
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
    
    func map(property: PropertySearch.Response.Property, isHighlighted: Bool) -> PropertyViewModel {
        PropertyViewModel(
            id: property.id,
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
}
